# Learn Design System

Bộ đặc tả thiết kế 1.3.0 cho website và ứng dụng nghe học Vi Learn: **16 foundation, 64 component, 8 compose**, token light/dark đầy đủ. Mỗi component có một file Markdown riêng với mục đích, cấu tạo, số đo, biến thể, trạng thái, cách dùng, khi không được dùng, hợp đồng dữ liệu, keyboard/semantics, responsive và tiêu chí nghiệm thu.

Đọc [MASTER](MASTER.md) trước, rồi [ma trận chọn component](component-selection.md). [Nguồn nghiên cứu](research/sources.md) ghi phần trích xuất OneNotch và phần bổ sung. Đặc tả bao phủ rộng hơn implementation Flutter hiện tại. API đã triển khai được liệt kê trong [README package](../README.md).

## Foundation

- [Nguyên tắc thiết kế](foundation/principles.md)
- [Màu sắc](foundation/color.md)
- [Typography](foundation/typography.md)
- [Spacing và kích thước](foundation/spacing-sizing.md)
- [Layout và responsive](foundation/layout-responsive.md)
- [Shape và border](foundation/shape-border.md)
- [Elevation và layer](foundation/elevation-layer.md)
- [Motion](foundation/motion.md)
- [Iconography](foundation/iconography.md)
- [Imagery](foundation/imagery.md)
- [Interaction và accessibility](foundation/interaction-accessibility.md)
- [Content và localization](foundation/content-localization.md)
- [Form và validation](foundation/forms-validation.md)
- [Media accessibility](foundation/media-accessibility.md)
- [Token và theming](foundation/tokens-theming.md)
- [Dữ liệu và trực quan hóa](foundation/data-visualization.md)

## Component · Actions

- [Button](component/button.md)
- [Icon button](component/icon-button.md)
- [Text link](component/text-link.md)

## Component · Forms

- [Form field](component/form-field.md)
- [Text input](component/text-input.md)
- [Textarea](component/textarea.md)
- [Search](component/search.md)
- [Select](component/select.md)
- [Combobox](component/combobox.md)
- [Checkbox](component/checkbox.md)
- [Radio group](component/radio-group.md)
- [Switch](component/switch.md)
- [Slider](component/slider.md)
- [Tag input](component/tag-input.md)
- [Date picker](component/date-picker.md)
- [Date range picker](component/date-range-picker.md)
- [File upload](component/file-upload.md)

## Component · Navigation

- [Tabs](component/tabs.md)
- [Segmented control](component/segmented-control.md)
- [Navbar](component/navbar.md)
- [Sidebar](component/sidebar.md)
- [Breadcrumb](component/breadcrumb.md)
- [Pagination](component/pagination.md)
- [Stepper](component/stepper.md)
- [Menu](component/menu.md)
- [Toolbar](component/toolbar.md)

## Component · Surfaces

- [Card](component/card.md)
- [Divider](component/divider.md)
- [Accordion](component/accordion.md)
- [Avatar](component/avatar.md)
- [Avatar group](component/avatar-group.md)
- [Badge](component/badge.md)
- [Image](component/image.md)
- [Carousel](component/carousel.md)
- [Tooltip](component/tooltip.md)
- [Popover](component/popover.md)
- [Dialog](component/dialog.md)
- [Drawer / Sheet](component/drawer.md)

## Component · Feedback

- [Alert](component/alert.md)
- [Banner](component/banner.md)
- [Toast](component/toast.md)
- [Empty state](component/empty-state.md)
- [Loading indicator](component/loading-indicator.md)
- [Skeleton](component/skeleton.md)
- [Progress](component/progress.md)
- [Error state](component/error-state.md)

## Component · Data

- [List / List item](component/list.md)
- [Data table](component/data-table.md)
- [Stat](component/stat.md)
- [Markdown](component/markdown.md)
- [Code block](component/code-block.md)

## Component · Learning

- [Lesson card](component/lesson-card.md)
- [Topic card](component/topic-card.md)
- [Audio player](component/audio-player.md)
- [Mini player](component/mini-player.md)
- [Seek bar](component/seek-bar.md)
- [Waveform](component/waveform.md)
- [Speed control](component/speed-control.md)
- [Transcript](component/transcript.md)
- [Vocabulary card](component/vocabulary-card.md)
- [Dictionary popover](component/dictionary-popover.md)
- [Review card](component/review-card.md)
- [Learning progress](component/learning-progress.md)
- [Download status](component/download-status.md)

## Pattern ghép màn hình

- [Landing page](compose/landing.md)
- [Khám phá bài nghe](compose/discovery.md)
- [Phiên nghe và transcript](compose/lesson-session.md)
- [Lưu từ và ôn tập](compose/vocabulary-review.md)
- [Onboarding](compose/onboarding.md)
- [Cài đặt](compose/settings.md)
- [Ngoại tuyến và download](compose/offline.md)

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
