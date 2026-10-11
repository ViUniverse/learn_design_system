# Checkbox

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn các mục độc lập hoặc xác nhận một điều kiện trước khi submit; nhiều mục có thể cùng được chọn.

## Cấu tạo

Native box; check/mixed mark không chỉ dựa màu; label tappable; optional description có quan hệ với control/group.

## Thông số và token

Glyph 20px trong label target ≥44px; unselected border-control, selected primary/on-primary; gap 12px.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

binary; mixed cho parent chọn nhóm. Mixed không phải giá trị thứ ba của preference cá nhân.

## Trạng thái và chuyển trạng thái

Unchecked/checked/mixed/focus/disabled; invalid được thông báo ở group/field. Label không đổi khi checked.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Chọn nhiều bài để tải.
- Chọn bộ chủ đề quan tâm.
- Xác nhận tùy chọn khi form cần lưu.

## Không được dùng khi nào

- Không thay switch có hiệu lực tức thì.
- Không thay radio cho chọn một.
- Không đặt link bên trong label gây toggle bất ngờ.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `checked` | `boolean` | bắt buộc |
| `indeterminate` | `boolean` | false |
| `label` | `string` | bắt buộc |
| `disabled` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "checked": true,
  "label": "Tải kèm bản chép lời",
  "indeterminate": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Space toggle; Tab đến từng checkbox. Native indeterminate và aria-checked=mixed khi custom equivalent.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Toàn label tappable, text nhiều dòng; description thẳng với label; target không chồng checkbox kế.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Click label toggle một lần.
- Mixed select-all đúng.
- Disabled không đổi.
- Group có legend.
- Checked không chỉ màu.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[radio-group](./radio-group.md) · [switch](./switch.md) · [form-field](./form-field.md)

Tham khảo pattern: [APG Checkbox](https://www.w3.org/WAI/ARIA/apg/patterns/checkbox/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
