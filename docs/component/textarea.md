# Textarea

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nhập ghi chú hoặc phản hồi nhiều dòng có thể chỉnh sửa và đọc lại đầy đủ.

## Cấu tạo

Form field; multiline control; optional counter; helper/error.

## Thông số và token

Min-height 120px, padding 12–16px, radius-md, line-height 1.5; resize dọc hoặc auto-grow có giới hạn phù hợp viewport.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

fixed-min-height; auto-grow; readOnly. Counter chỉ có khi tồn tại giới hạn thực.

## Trạng thái và chuyển trạng thái

Empty/filled/focused/invalid/disabled/readOnly; at-limit giữ value, chỉ rõ số còn lại; pending không xóa nháp.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Ghi chú sau bài nghe.
- Câu trả lời tự luận.
- Phản hồi chất lượng bản chép lời.

## Không được dùng khi nào

- Không dùng cho email/tên ngắn.
- Không làm rich text editor giả.
- Không cấm xuống dòng bằng cách dùng textarea một hàng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `string` | bắt buộc |
| `minRows` | `number` | 4 |
| `maxLength` | `number|null` | null |
| `autoGrow` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "Từ mới hôm nay: slow down",
  "minRows": 4,
  "autoGrow": true,
  "label": "Ghi chú"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter tạo dòng mới; Ctrl/Cmd+Enter gửi chỉ khi shortcut được giải thích. Tab đi control kế, không chèn tab mặc định.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Không dùng fixed height che nội dung; tránh auto-grow đẩy action khỏi màn hình vô hạn; không khóa zoom.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Unicode counter theo quy tắc app.
- Paste nhiều dòng.
- Resize không cắt ring.
- Enter không gửi nhầm.
- Nháp giữ qua lỗi submit.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[form-field](./form-field.md) · [text-input](./text-input.md) · [markdown](./markdown.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
