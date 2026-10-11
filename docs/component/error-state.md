# Error state

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Vùng lỗi blocking việc hiển thị nội dung với nguyên nhân có thể nói được và đường khôi phục.

## Cấu tạo

Status icon; title; message; retry/alternative; optional support reference không chứa secret.

## Thông số và token

Padding24/32, error foreground/icon, text-primary/body; action Button; max-width480; giữ context lesson/query.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

network; unavailable; permission; not-found. Form error inline không cần whole-region error.

## Trạng thái và chuyển trạng thái

Error/retrying/recovered; retry idempotent, không reset tiến độ/nháp không liên quan; unknown nguyên nhân không bịa.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Audio không tải được.
- Lesson bị gỡ.
- Catalog request thất bại.
- Không có quyền tài nguyên.

## Không được dùng khi nào

- Không dùng cho empty search.
- Không lộ stack trace/provider key.
- Không Retry vô dụng khi permission denied.
- Không clear user data.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `kind` | `enum` | network |
| `title` | `string` | bắt buộc |
| `message` | `string` | bắt buộc |
| `retry` | `Action|null` | null |
| `alternative` | `Action|null` | null |
| `retrying` | `boolean` | false |

### Ví dụ cấu hình / nội dung

```json
{
  "kind": "network",
  "title": "Chưa tải được bài nghe",
  "message": "Kiểm tra kết nối rồi thử lại.",
  "retry": {
    "id": "retry",
    "label": "Thử lại"
  }
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Actions native; retry pending giữ focus; khi recovered trả focus hợp lý; live region một lần khi lỗi mới.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Stack actions compact; message wrap đầy đủ; trong player vẫn cho đọc transcript nếu có.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Retry thành công/thất bại.
- Offline reason.
- Alternative khả dụng.
- Không dữ liệu giả.
- Focus stable khi recovered.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[alert](./alert.md) · [empty-state](./empty-state.md) · [audio-player](./audio-player.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
