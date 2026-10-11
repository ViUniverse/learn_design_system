# Drawer / Sheet

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Panel từ cạnh hoặc đáy cho navigation mobile hoặc tác vụ ngắn cần nhiều diện tích hơn popover.

## Cấu tạo

Backdrop nếu modal; panel; title; close; content; optional handle decorative; actions.

## Thông số và token

Side width min(360,viewport-32); bottom panel radius-panel phía trên; padding16/24, surface-raised, overlay, safe-area.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

side navigation; bottom task sheet; nonmodal persistent panel (không backdrop/inert).

## Trạng thái và chuyển trạng thái

Closed/open/dragging nếu hỗ trợ; loading/error content; resize sang persistent giải phóng scroll lock/focus trap.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Mobile navigation.
- Danh sách từ.
- Player settings trên màn hình nhỏ.

## Không được dùng khi nào

- Không bắt kéo để đóng.
- Không giữ aria-modal khi persistent.
- Không chứa task nhiều trang trong sheet thấp.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `open` | `boolean` | bắt buộc |
| `edge` | `enum` | bottom |
| `modal` | `boolean` | true |
| `title` | `string` | bắt buộc |
| `onClose` | `callback` | bắt buộc |
| `content` | `slot` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "open": true,
  "edge": "bottom",
  "modal": true,
  "title": "Từ vựng trong bài"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Modal theo Dialog focus/inert/Esc/restore; close button luôn nhìn; nonmodal Tab bình thường. Handle không nhận Tab nếu decorative.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Chọn edge phù hợp width; keyboard mở không che field; height dùng dynamic viewport/safe-area và scroll content.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Esc và close không cần drag.
- Background lock chỉ modal.
- Resize cleanup.
- Focus không bị mini player che.
- Long content đọc hết.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[dialog](./dialog.md) · [navbar](./navbar.md) · [vocabulary-card](./vocabulary-card.md)

Tham khảo pattern: [APG Drawer / Sheet](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
