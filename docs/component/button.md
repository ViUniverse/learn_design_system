# Button

Nhóm: Actions · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Thực thi một hành động như bắt đầu nghe, lưu thay đổi hoặc thử tải lại. Một vùng quyết định chỉ có một nút primary.

## Cấu tạo

Container; label động từ; leading/trailing icon tùy chọn; indicator khi pending.

## Thông số và token

Visual height 32/44/56px, hit target 44px; gap 8px, padding-inline 16/24px, radius-pill. Primary dùng primary/on-primary; secondary dùng surface/text-primary và border-control.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

primary; secondary; ghost; danger. Size sm chỉ desktop dense; md mặc định; lg hero. Full-width chỉ form/hero hẹp.

## Trạng thái và chuyển trạng thái

Default/hover/focus/pressed; pending giữ label và width, ngăn gửi lặp; disabled không nhận action. Error nằm ở tác vụ hoặc field liên quan, không chỉ đổi nút đỏ.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Nghe bài đang chọn.
- Submit form cài đặt có nút Lưu.
- Retry lỗi audio có thể phục hồi.

## Không được dùng khi nào

- Không thay link đi route.
- Không dùng nhiều primary cạnh nhau.
- Không dùng disabled để giấu lý do thiếu quyền mà không có mô tả.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `variant` | `enum` | primary |
| `size` | `enum` | md |
| `loading` | `boolean` | false |
| `disabled` | `boolean` | false |
| `onActivate` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Nghe bài",
  "variant": "primary",
  "size": "md",
  "loading": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Button native nhận Enter/Space. Focus giữ nguyên trong pending nếu có thể; khi hoàn thành route mới đặt focus theo routing, không do nút tự quyết.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Label xuống dòng và nút nở; nhóm action wrap. Không đảo DOM Cancel/Confirm chỉ để khớp desktop.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Enter/Space gọi action đúng một lần.
- Pending không double submit.
- Label dài và 200% scale không bị cắt.
- Tất cả variant có focus và cặp màu đúng theme.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[icon-button](./icon-button.md) · [text-link](./text-link.md) · [loading-indicator](./loading-indicator.md)

Tham khảo pattern: [APG Button](https://www.w3.org/WAI/ARIA/apg/patterns/button/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
