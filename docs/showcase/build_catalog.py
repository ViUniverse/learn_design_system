"""Expose the authored specs to the local, buildless showcase."""
import json, runpy
from pathlib import Path
root = Path(__file__).resolve().parent.parent
manifest = json.loads((root / 'manifest.json').read_text())
components = runpy.run_path(str(root / 'tools/component_specs.py'))['SPECS']
for section in ['foundation', 'compose']:
    for item in manifest[section]:
        item['document'] = (root / item['path']).read_text()
for item in components:
    item['document'] = (root / 'component' / (item['slug'] + '.md')).read_text()
manifest['component'] = components
manifest['tokensData'] = json.loads((root / 'tokens/design-tokens.json').read_text())
(root / 'showcase/catalog.js').write_text('window.CATALOG = ' + json.dumps(manifest, ensure_ascii=False) + ';\n')
print('Published: ' + ', '.join(f'{len(manifest[group])} {group}' for group in ['foundation', 'component', 'compose']))
