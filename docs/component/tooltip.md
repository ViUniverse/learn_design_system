# Tooltip

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Giải thích bổ sung ngắn cho control đã có accessible name; không chứa thao tác cần bấm.

## Cấu tạo

Trigger hiện hữu; floating text; optional arrow trang trí; description association.

## Thông số và token

Small14, padding8/12, radius-sm, surface-raised/text-primary/border-subtle, shadow-sm; max-width240.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

text-only giải thích bổ sung ngắn; shortcut hint đi cùng action đã có name. Không interactive tooltip chứa button/link.

## Trạng thái và chuyển trạng thái

Hidden/hover-visible/focus-visible; Esc dismiss; hover chuyển lên tooltip vẫn giữ đủ đọc; touch có cơ chế phù hợp nhưng không chứa thông tin bắt buộc.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Nút Tua lại 10 giây đã có accessible name.
- Giải thích icon tốc độ cho người mới.
- Shortcut phụ không là đường duy nhất thực thi action.

## Không được dùng khi nào

- Không thay label/error/helper.
- Không chứa link/form.
- Không thông tin duy nhất trên mobile.
- Không thêm focus trigger decorative.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `text` | `string` | bắt buộc |
| `trigger` | `existing-control` | bắt buộc |
| `placement` | `enum` | auto |
| `delayMs` | `number` | 400 |

### Ví dụ cấu hình / nội dung

```json
{
  "text": "Tua lại 10 giây",
  "placement": "auto",
  "delayMs": 400
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Focus trigger hiển thị; Esc đóng; tooltip không nhận Tab. aria-describedby khi có text bổ sung thực.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Reposition trong viewport, wrap; không che trigger/focus; tooltip dài đổi thành Popover/help text.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Hover/focus đều có.
- Esc hoạt động.
- Không trap pointer.
- Mô tả không đọc lặp name.
- Touch vẫn biết action.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[icon-button](./icon-button.md) · [popover](./popover.md) · [form-field](./form-field.md)

Tham khảo pattern: [APG Tooltip](https://www.w3.org/WAI/ARIA/apg/patterns/tooltip/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
