# Alert

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Thông tin inline liên quan ngay vùng công việc, có ý nghĩa và tồn tại đủ để đọc/sửa.

## Cấu tạo

Status icon; title tùy độ dài; message; optional action/close.

## Thông số và token

Padding16, radius-md, semantic background/foreground pair; icon20; message body/small; không chỉ viền màu.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

info; success; warning; error. Dismissible chỉ thông tin có thể bỏ mà không mất instruction bắt buộc.

## Trạng thái và chuyển trạng thái

Visible/dismissed; pending action; resolved sau app xác nhận. Chỉ announce lần có nội dung mới.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lỗi tải transcript có retry.
- Giới hạn storage.
- Mô tả chế độ offline cho vùng lesson.

## Không được dùng khi nào

- Không cho lỗi field đơn lẻ.
- Không thay dialog cần quyết định.
- Không dùng assertive cho tin thường.
- Không lặp mọi poll.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `tone` | `enum` | info |
| `title` | `string|null` | null |
| `message` | `string` | bắt buộc |
| `action` | `Action|null` | null |
| `dismissible` | `boolean` | false |

### Ví dụ cấu hình / nội dung

```json
{
  "tone": "error",
  "message": "Chưa tải được bản chép lời.",
  "action": {
    "label": "Thử lại",
    "id": "retry"
  }
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Message không focus mặc định; actions native; close có name. role=status/polite cho tin thường, alert cho lỗi cần chú ý ngay.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Action xuống dòng; message không truncate; icon không mất khi long text; không ép height.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Screen reader không đọc lặp.
- Icon/text đúng tone.
- Dismiss không xóa error còn tồn tại.
- Retry giữ context.
- Text contrast.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[banner](./banner.md) · [toast](./toast.md) · [error-state](./error-state.md)

Tham khảo pattern: [APG Alert](https://www.w3.org/WAI/ARIA/apg/patterns/alert/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
