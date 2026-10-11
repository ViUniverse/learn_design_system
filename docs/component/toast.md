# Toast

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Phản hồi ngắn sau action, không yêu cầu người dùng đọc/gõ ngay để tiếp tục.

## Cấu tạo

Live-region host; message; optional Undo; close; queue quản lý.

## Thông số và token

Surface-raised/text-primary/border-subtle, radius-lg/shadow-md, padding16; max-width360; layer-toast không chắn player.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

confirmation; undoable; error-summary chỉ khi chi tiết tồn tại inline.

## Trạng thái và chuyển trạng thái

Queued/visible/paused/dismissed; default 6s cho tin ngắn, pause khi hover/focus. Action quan trọng không chỉ sống trong timeout.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Đã lưu bài sau persistence.
- Đã sao chép link.
- Undo xóa tag có đường thay thế bền vững.

## Không được dùng khi nào

- Không nơi duy nhất báo field error.
- Không thông báo tiến độ liên tục.
- Không request decision nguy hiểm.
- Không chỉ toast cho offline toàn app.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `message` | `string` | bắt buộc |
| `action` | `Action|null` | null |
| `durationMs` | `number` | 6000 |
| `id` | `string` | bắt buộc |
| `onDismiss` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "id": "saved-lesson-1",
  "message": "Đã lưu bài nghe.",
  "durationMs": 6000
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Không giành focus khi xuất hiện; action/close tabbable khi nhìn thấy; pause timeout khi focus; polite announcement.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Placement tránh navbar/mini player và safe-area; mobile width viewport-32; queue không phủ phần lớn màn hình.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- No duplicate queue.
- Timeout pause.
- Screen reader announce một lần.
- Action không mất khi focus.
- Saved dựa confirmation thật.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[alert](./alert.md) · [banner](./banner.md) · [button](./button.md)

Tham khảo pattern: [APG Toast](https://www.w3.org/WAI/ARIA/apg/patterns/alert/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
