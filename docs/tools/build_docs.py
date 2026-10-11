"""Publish each authored component as a standalone Markdown document."""
from pathlib import Path
import json
import sys
sys.dont_write_bytecode = True
from component_specs import SPECS

ROOT = Path(__file__).resolve().parents[1]
FOUNDATIONS = [
    ('principles', 'Nguyên tắc thiết kế'), ('color', 'Màu sắc'), ('typography', 'Typography'),
    ('spacing-sizing', 'Spacing và kích thước'), ('layout-responsive', 'Layout và responsive'),
    ('shape-border', 'Shape và border'), ('elevation-layer', 'Elevation và layer'), ('motion', 'Motion'),
    ('iconography', 'Iconography'), ('imagery', 'Imagery'),
    ('interaction-accessibility', 'Interaction và accessibility'), ('content-localization', 'Content và localization'),
    ('forms-validation', 'Form và validation'), ('media-accessibility', 'Media accessibility'),
    ('tokens-theming', 'Token và theming'), ('data-visualization', 'Dữ liệu và trực quan hóa'),
]
COMPOSES = [('landing', 'Landing page'), ('discovery', 'Khám phá bài nghe'),
            ('lesson-session', 'Phiên nghe và transcript'), ('vocabulary-review', 'Lưu từ và ôn tập'),
            ('onboarding', 'Onboarding'), ('settings', 'Cài đặt'), ('offline', 'Ngoại tuyến và download'), ('adaptive-window', 'Adaptive window')]


def bullets(text):
    items = [item.strip().rstrip('.') for item in text.split(';') if item.strip()]
    return '\n'.join('- ' + item[0].upper() + item[1:] + '.' for item in items)


def build():
    version = json.loads((ROOT / 'tokens/design-tokens.json').read_text())['metadata']['version']
    components = ROOT / 'component'
    components.mkdir(exist_ok=True)
    for spec in SPECS:
        prop_rows = []
        for prop in spec['props'].split(';'):
            name, kind, default = (value.strip() for value in prop.split(':', 2))
            prop_rows.append(f'| `{name}` | `{kind}` | {default} |')
        if spec['source'] == 'forms':
            source = '[WAI Forms](https://www.w3.org/WAI/tutorials/forms/)'
        elif spec['source'] == 'media':
            source = '[WAI Media](https://www.w3.org/WAI/media/av/)'
        elif spec['source'] == 'landmarks':
            source = '[APG Landmark regions](https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/)'
        elif spec['source']:
            source = f'[APG {spec["title"]}](https://www.w3.org/WAI/ARIA/apg/patterns/{spec["source"]}/)'
        else:
            source = '[Quyết định thiết kế Vi Learn](../MASTER.md)'
        related = ' · '.join(f'[{s}](./{s}.md)' for s in spec['related'])
        text = f'''# {spec['title']}

Nhóm: {spec['category']} · Phiên bản {version} · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

{spec['purpose']}

## Cấu tạo

{spec['anatomy']}

## Thông số và token

{spec['geometry']}

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

{spec['variants']}

## Trạng thái và chuyển trạng thái

{spec['states']}

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

{bullets(spec['use'])}

## Không được dùng khi nào

{bullets(spec['avoid'])}

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
{chr(10).join(prop_rows)}

### Ví dụ cấu hình / nội dung

```json
{json.dumps(spec['example'], ensure_ascii=False, indent=2)}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

{spec['keyboard']}

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

{spec['responsive']}

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

{bullets(spec['checks'])}

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

{related}

Tham khảo pattern: {source}. Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
'''
        (components / f'{spec["slug"]}.md').write_text(text)
    manifest = {
        'name': 'Learn Design System', 'version': version, 'scope': 'design-specification',
        'foundation': [{'id': key, 'title': title, 'path': f'foundation/{key}.md'} for key, title in FOUNDATIONS],
        'component': [{'id': s['slug'], 'title': s['title'], 'category': s['category'], 'path': f'component/{s["slug"]}.md'} for s in SPECS],
        'compose': [{'id': key, 'title': title, 'path': f'compose/{key}.md'} for key, title in COMPOSES],
        'tokens': ['tokens/design-tokens.json', 'tokens/design-tokens.css'],
        'coverage': {'foundation': len(FOUNDATIONS), 'component': len(SPECS), 'compose': len(COMPOSES)}
    }
    (ROOT / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    readme = '''# Learn Design System

Bộ đặc tả thiết kế 1.3.0 cho website và ứng dụng nghe học Vi Learn: **16 foundation, 64 component, 8 compose**, token light/dark đầy đủ. Mỗi component có một file Markdown riêng với mục đích, cấu tạo, số đo, biến thể, trạng thái, cách dùng, khi không được dùng, hợp đồng dữ liệu, keyboard/semantics, responsive và tiêu chí nghiệm thu.

Đọc [MASTER](MASTER.md) trước, rồi [ma trận chọn component](component-selection.md). [Nguồn nghiên cứu](research/sources.md) ghi phần trích xuất OneNotch và phần bổ sung. Đây là bộ đặc tả và token, không phải thư viện widget Flutter đã triển khai; API Flutter hiện có được liệt kê trong README của package.

## Foundation

'''
    readme += '\n'.join(f'- [{title}](foundation/{key}.md)' for key, title in FOUNDATIONS)
    for category in dict.fromkeys(s['category'] for s in SPECS):
        readme += f'\n\n## Component · {category}\n\n'
        readme += '\n'.join(f'- [{s["title"]}](component/{s["slug"]}.md)' for s in SPECS if s['category'] == category)
    readme += '\n\n## Pattern ghép màn hình\n\n'
    readme += '\n'.join(f'- [{title}](compose/{key}.md)' for key, title in COMPOSES)
    readme += '''

## Token và sử dụng

- [JSON nguồn](tokens/design-tokens.json): color primitive/semantic, font/type, spacing/size/layout, radius/border, motion/layer/shadow.
- [CSS sinh tự động](tokens/design-tokens.css): `--vl-*`, light/dark/system và reduced-motion.
- [Model/hợp đồng chung](contracts.md) · [Governance](governance.md) · [Manifest coverage](manifest.json).

```sh
python3 docs/tools/build_tokens.py
python3 docs/tools/build_docs.py
python3 docs/tools/validate.py
```

`tools/component_specs.py` chứa nội dung component đã biên soạn; sửa nguồn này rồi sinh lại Markdown để tránh mất sửa đổi. Foundation và pattern được biên soạn trực tiếp. [Báo cáo kiểm tra](verification/report.json) có phạm vi và kết quả; các checklist runtime trong component chờ implementation được kiểm tra trên nền tảng thực.
'''
    (ROOT / 'README.md').write_text(readme.replace('1.3.0', version))
    return len(SPECS)


if __name__ == '__main__':
    print(f'Published {build()} component Markdown documents')
