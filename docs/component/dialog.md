# Dialog

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tác vụ hoặc quyết định ngắn cần tạm chặn nền để người dùng tập trung, với đường đóng rõ.

## Cấu tạo

Backdrop; modal surface; title; description/content; close/cancel; primary action.

## Thông số và token

Width min(viewport-32,480/640), padding24, radius-panel, surface-raised/border-subtle/shadow-lg, overlay theme.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

standard; confirmation-danger với least-destructive initial focus; form-dialog. Alertdialog chỉ thông báo khẩn cần response.

## Trạng thái và chuyển trạng thái

Closed/open/submitting/error; background inert; action pending có feedback/cancel policy; unsaved close xác nhận khi cần.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Đổi tên playlist.
- Xác nhận xóa dữ liệu không dễ undo.
- Tác vụ nhỏ không cần route riêng.

## Không được dùng khi nào

- Không báo thành công thường xuyên.
- Không onboarding dài.
- Không mở modal chỉ để xem tooltip.
- Không nhiều dialog lồng theo mặc định.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `open` | `boolean` | bắt buộc |
| `title` | `string` | bắt buộc |
| `role` | `enum` | dialog |
| `initialFocus` | `target|null` | auto |
| `onClose` | `callback` | bắt buộc |
| `onConfirm` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "open": true,
  "title": "Xóa playlist này?",
  "role": "dialog",
  "initialFocus": "cancel",
  "confirmLabel": "Xóa playlist"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Mở focus bên trong; Tab/Shift+Tab giữ modal scope; Esc đóng theo policy không mất dữ liệu; restore trigger/logical next. Native dialog ưu tiên trên web.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Max-height theo viewport có content scroll; action/title accessible; narrow có thể full-screen nhưng giữ close và safe-area.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Nền inert thật.
- Title/name đúng.
- Keyboard cycle.
- Esc/close/return focus.
- Delete failure giữ context.
- Zoom không che action.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[popover](./popover.md) · [drawer](./drawer.md) · [button](./button.md)

Tham khảo pattern: [APG Dialog](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
