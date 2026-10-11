# Icon button

Nhóm: Actions · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Hành động quen thuộc trong player/toolbar khi không đủ chỗ cho label trực quan, vẫn có tên đầy đủ cho assistive technology.

## Cấu tạo

Hit region; glyph 20–24px; accessible name; tooltip bổ sung; optional pressed state.

## Thông số và token

Target 44×44px, glyph icon-md/lg; radius-pill hoặc md theo toolbar; glyph dùng text-secondary/link hoặc on-primary.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

neutral; primary; danger; toggle. Dùng toggle khi trạng thái như đã lưu có giá trị bền.

## Trạng thái và chuyển trạng thái

Hover/focus/pressed; toggled có aria-pressed; pending không đổi accessible name thành chuỗi mơ hồ; disabled giữ lý do ở nơi đọc được.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Play/pause đã quen thuộc.
- Bookmark trong lesson row.
- Đóng dialog có tiêu đề rõ.

## Không được dùng khi nào

- Không dùng cho action mới lạ không label.
- Không dùng icon-only làm CTA đầu tiên cho người mới.
- Không dùng glyph như decoration nhưng vẫn nhận Tab.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `icon` | `icon-id` | bắt buộc |
| `label` | `string` | bắt buộc |
| `pressed` | `boolean|null` | null |
| `disabled` | `boolean` | false |
| `onActivate` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "icon": "bookmark-check",
  "label": "Bỏ lưu bài The art of slowing down",
  "pressed": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter/Space kích hoạt; Tab đến target, không đến glyph. Tên đổi Phát/Tạm dừng theo hành động tiếp theo.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Giữ 44px trên mobile, không thu target để vừa hàng. Chuyển action thứ cấp vào menu khi thiếu chỗ.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Screen reader có name/pressed đúng.
- Touch không đè target seek.
- Tooltip không là nơi duy nhất có label.
- Esc không kích hoạt nút.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[button](./button.md) · [tooltip](./tooltip.md) · [toolbar](./toolbar.md)

Tham khảo pattern: [APG Icon button](https://www.w3.org/WAI/ARIA/apg/patterns/button/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
