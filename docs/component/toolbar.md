# Toolbar

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nhóm các control liên quan một vùng nội dung để giảm số Tab stop khi nhóm đủ lớn.

## Cấu tạo

Toolbar label; action/toggle groups; separators; optional overflow.

## Thông số và token

Button target44, glyph20; gap8; group gap16; surface khi cần; divider không focusable.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

horizontal; vertical; wrapping simple actions (không composite) khi thích hợp.

## Trạng thái và chuyển trạng thái

Focused control/pressed toggle/disabled; hidden overflow không còn focusable; selection của control độc lập.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Hàng điều khiển player.
- Editor notes có nhiều tools.
- Batch actions trên table.

## Không được dùng khi nào

- Không gắn toolbar role vào mọi cặp button.
- Không đặt nhiều text inputs có arrows editing vào composite mà không quy tắc.
- Không dùng icon mơ hồ.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `items` | `Control[]` | bắt buộc |
| `orientation` | `enum` | horizontal |
| `overflow` | `Control[]` | rỗng |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Điều khiển bài nghe",
  "orientation": "horizontal",
  "items": [
    "back10",
    "play",
    "forward10",
    "speed"
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Composite toolbar Tab một stop, arrows roving/Home/End; controls có editing arrows cần mô tả chế độ riêng. Nhóm nhỏ thường dùng buttons native với Tab bình thường.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Wrap hoặc overflow; giữ primary playback luôn nhìn thấy; không ép một hàng trên mobile.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Roving không nuốt slider arrows.
- Focus vào overflow đúng.
- Labels mỗi icon.
- Disabled item không kích hoạt.
- Mobile không mất play.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[icon-button](./icon-button.md) · [menu](./menu.md) · [audio-player](./audio-player.md)

Tham khảo pattern: [APG Toolbar](https://www.w3.org/WAI/ARIA/apg/patterns/toolbar/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
