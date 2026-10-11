"""Audit documented scope, source/output consistency, links and color contrast."""
from pathlib import Path
from datetime import datetime, timezone
import json
import re
import sys
sys.dont_write_bytecode = True
from component_specs import SPECS
from build_tokens import render

ROOT = Path(__file__).resolve().parents[1]
errors = []


def require(condition, message):
    if not condition:
        errors.append(message)


def luminance(value):
    values = [int(value[i:i + 2], 16) / 255 for i in (1, 3, 5)]
    linear = [v / 12.92 if v <= .04045 else ((v + .055) / 1.055) ** 2.4 for v in values]
    return sum(v * w for v, w in zip(linear, [.2126, .7152, .0722]))


def contrast(a, b):
    high, low = sorted([luminance(a), luminance(b)], reverse=True)
    return (high + .05) / (low + .05)


manifest = json.loads((ROOT / 'manifest.json').read_text())
tokens = json.loads((ROOT / 'tokens/design-tokens.json').read_text())
expected = {'foundation': 16, 'component': 64, 'compose': 8}
for group, count in expected.items():
    require(len(manifest[group]) == count, f'{group}: expected {count} catalog entries')
    require(len({item['id'] for item in manifest[group]}) == count, f'{group}: duplicate IDs')
    for item in manifest[group]:
        require((ROOT / item['path']).is_file(), f'Missing catalog file: {item["path"]}')
        require((ROOT / item['path']).stat().st_size > 1000, f'Thin catalog file: {item["path"]}')
    actual = {p.relative_to(ROOT).as_posix() for p in (ROOT / group).glob('*.md')}
    require(actual == {item['path'] for item in manifest[group]}, f'{group}: actual Markdown/catalog mismatch')

require(len(SPECS) == 64, 'Authored spec count differs from scope')
require({s['slug'] for s in SPECS} == {s['id'] for s in manifest['component']}, 'Manifest/authored IDs differ')
categories = {category: sum(s['category'] == category for s in SPECS) for category in sorted({s['category'] for s in SPECS})}
require(categories == {'Actions': 3, 'Data': 5, 'Feedback': 8, 'Forms': 14, 'Learning': 13, 'Navigation': 9, 'Surfaces': 12}, 'Component category coverage incomplete')
sections = ['Mục đích và phạm vi', 'Cấu tạo', 'Thông số và token', 'Biến thể',
            'Trạng thái và chuyển trạng thái', 'Khi nên dùng', 'Không được dùng khi nào',
            'Cách dùng và hợp đồng', 'Bàn phím và semantics', 'Responsive, localization và motion',
            'Tiêu chí nghiệm thu', 'Liên quan và nguồn']
component_audits = []
for spec in SPECS:
    text = (ROOT / 'component' / (spec['slug'] + '.md')).read_text()
    for title in sections:
        require(f'## {title}\n' in text, f'{spec["slug"]}: missing {title}')
    for field in ['purpose', 'anatomy', 'geometry', 'variants', 'states', 'use', 'avoid', 'keyboard', 'responsive', 'checks']:
        require(len(spec[field]) >= 60, f'{spec["slug"]}: insufficient specific {field}')
        require(spec[field] in text or field in ['use', 'avoid', 'checks'], f'{spec["slug"]}: authored {field} missing from output')
    for field in ['use', 'avoid']:
        require(len(spec[field].split(';')) >= 2, f'{spec["slug"]}: {field} lacks alternative cases')
    props = [p.split(':', 2) for p in spec['props'].split(';')]
    require(len(props) >= 3 and all(len(p) == 3 for p in props), f'{spec["slug"]}: incomplete property contract')
    require(len({p[0] for p in props}) == len(props), f'{spec["slug"]}: duplicate properties')
    examples = re.findall(r'```json\n(.*?)\n```', text, re.S)
    require(len(examples) == 1 and json.loads(examples[0]) == spec['example'], f'{spec["slug"]}: example mismatch')
    require(len(spec['related']) >= 2, f'{spec["slug"]}: insufficient comparison links')
    component_audits.append({'id': spec['slug'], 'sections': len(sections), 'propertyCount': len(props), 'example': 'valid JSON', 'specificPolicy': True})

link_count = 0
external_links = set()
markdown = list(ROOT.rglob('*.md'))
for path in markdown:
    text = path.read_text()
    require(not re.search(r'\b(TODO|TBD|FIXME)\b', text), f'Unfinished marker: {path.relative_to(ROOT)}')
    require(text.count('```') % 2 == 0, f'Unclosed code fence: {path.relative_to(ROOT)}')
    for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', text):
        link_count += 1
        if target.startswith(('https://', 'http://')):
            external_links.add(target)
        elif not target.startswith('#'):
            relative = target.split('#', 1)[0]
            require((path.parent / relative).exists(), f'Broken link {path.relative_to(ROOT)} -> {target}')

colors = tokens['color']['themes']
require(set(colors) == {'light', 'dark'}, 'Missing light/dark theme')
require(set(colors['light']) == set(colors['dark']) == set(tokens['color']['roles']), 'Theme/role keys differ')
require(len(colors['light']) == 41, 'Accepted semantic palette missing roles')
for theme, palette in colors.items():
    for key, value in palette.items():
        require(bool(re.fullmatch(r'#[0-9A-F]{6}([0-9A-F]{2})?', value)), f'Invalid color: {theme}.{key}')
css = (ROOT / 'tokens/design-tokens.css').read_text()
require(css == render(), 'CSS is not synchronized with JSON source')
defined = set(re.findall(r'(--vl-[a-z0-9-]+)\s*:', css))
references = set(re.findall(r'var\((--vl-[a-z0-9-]+)', css))
require(references <= defined, f'CSS token refs missing: {references - defined}')
for path in markdown:
    text = path.read_text()
    refs = set(re.findall(r'(--vl-[a-z0-9-]+)', text))
    refs -= {'--vl-space-4'} if '--vl-space-4' in defined else set()
    require(refs <= defined, f'Unknown Markdown token reference in {path.relative_to(ROOT)}: {refs - defined}')

contrast_checks = []
def add_pair(theme, fg, bg, threshold):
    palette = colors[theme]
    value = contrast(palette[fg], palette[bg])
    contrast_checks.append({'theme': theme, 'foreground': fg, 'background': bg, 'ratio': round(value, 4), 'threshold': threshold, 'pass': value >= threshold})
    require(value >= threshold, f'Contrast {theme} {fg}/{bg}: {value:.4f} < {threshold}')

for theme in colors:
    backgrounds = ['background', 'background-subtle', 'surface', 'surface-raised', 'surface-hover', 'input-background']
    for bg in backgrounds:
        for fg in ['text-primary', 'text-secondary', 'text-placeholder', 'link', 'link-hover']:
            add_pair(theme, fg, bg, 4.5)
    for fg, bg in ([('on-primary', 'primary'), ('on-primary', 'primary-hover'), ('on-primary', 'primary-pressed'),
                   ('selected-foreground', 'selected-background'), ('selected-foreground', 'selected-hover'),
                   ('on-danger', 'danger'), ('on-danger', 'danger-hover'), ('peach-foreground', 'peach-background')]
                   + [(s + '-foreground', s + '-background') for s in ['success', 'warning', 'error', 'info']]):
        add_pair(theme, fg, bg, 4.5)
    for fg in ['border-control', 'focus-ring', 'error-foreground', 'progress-active']:
        for bg in ['background', 'surface', 'surface-raised', 'surface-hover', 'input-background']:
            add_pair(theme, fg, bg, 3)
    add_pair(theme, 'progress-active', 'progress-track', 3)

report = {'name': 'Learn Design System specification audit', 'checkedAt': datetime.now(timezone.utc).isoformat(),
          'status': 'pass' if not errors else 'fail', 'scope': 'Written specification, generated tokens, local links and exact color pairs. No production widget behavior or device/screen-reader certification.',
          'coverage': {g: len(manifest[g]) for g in expected}, 'categories': categories,
          'markdownFiles': len(markdown), 'linksChecked': link_count, 'externalReferenceCount': len(external_links),
          'externalLinkScope': 'Source URLs documented from research; this validator does not fetch websites.',
          'semanticColorRolesPerTheme': len(colors['light']), 'cssVariables': len(defined), 'cssMatchesJSON': css == render(),
          'component': component_audits, 'contrastChecks': contrast_checks,
          'contrastExclusions': ['disabled text: inactive control only', 'decorative lavender/border-subtle', 'alpha overlay/shadow: require compositing before text tests', 'images/gradients not rendered by this specification audit'],
          'errors': errors}
(ROOT / 'verification').mkdir(exist_ok=True)
(ROOT / 'verification/report.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({k: report[k] for k in ['status', 'coverage', 'markdownFiles', 'linksChecked', 'semanticColorRolesPerTheme', 'cssVariables', 'cssMatchesJSON', 'errors']}, ensure_ascii=False))
print(f'Exact contrast pairs checked: {len(contrast_checks)}')
sys.exit(bool(errors))
