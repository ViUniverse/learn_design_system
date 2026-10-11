# File upload

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Cho người dùng chủ động chọn audio/transcript để nhập vào ứng dụng; transfer và parsing do app xử lý.

## Cấu tạo

Label; native file input/browse action; optional drop zone; file row; progress/error; remove/cancel.

## Thông số và token

Drop zone padding24/radius-card/border-control; browse button44; progress có số; filename wrap; không chỉ dashed border mờ.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

single; multiple; drag-enhanced. Accept/type/max-size ghi bằng text cạnh action.

## Trạng thái và chuyển trạng thái

Empty/drag-over/selected/validating/uploading/complete/failed/cancelled; selected không đồng nghĩa uploaded.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Import bài nghe cá nhân.
- Thêm transcript có quyền sử dụng.
- Upload cover tùy chọn.

## Không được dùng khi nào

- Không tự upload trước khi giải thích đích/phạm vi.
- Không bắt drag.
- Không tin extension là validation an toàn.
- Không khóa form vĩnh viễn khi lỗi.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `accept` | `string[]` | bắt buộc |
| `maxBytes` | `number` | bắt buộc |
| `multiple` | `boolean` | false |
| `files` | `FileState[]` | rỗng |
| `onChoose` | `callback` | bắt buộc |
| `onCancel` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "accept": [
    "audio/mpeg",
    "audio/mp4"
  ],
  "maxBytes": 25000000,
  "multiple": false,
  "label": "Thêm bài nghe của bạn"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Browse native bằng Enter/Space; remove/cancel mỗi file có label; drop không là đường duy nhất. Kết quả parse đọc polite.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Mobile ưu tiên browse; filename xuống dòng; progress và cancel không bị keyboard/viewport che.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Wrong MIME/size, duplicate, zero-byte, canceled picker.
- Retry không tạo bản ghi lặp.
- Offline progress không giả complete.
- Privacy phạm vi rõ.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[button](./button.md) · [progress](./progress.md) · [error-state](./error-state.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
