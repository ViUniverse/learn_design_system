# Divider

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tách các nhóm nội dung đã có cấu trúc, tạo nhịp đọc mà không thêm chrome.

## Cấu tạo

Rule ngang/dọc không focusable; optional label giữa nếu có ý nghĩa; khoảng trắng hai phía theo nhịp grouping của vùng.

## Thông số và token

Border1px border-subtle; margin16/24 theo grouping; label small text-secondary.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

horizontal; vertical trong toolbar; labeled separator như Hoặc.

## Trạng thái và chuyển trạng thái

Static; không loading/disabled/selected. Semantic separator chỉ nếu thực sự phân nhóm, decorative aria-hidden khi dư.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Tách metadata/action.
- Giữa nhóm menu.
- Giữa lựa chọn đăng nhập nếu flow có.

## Không được dùng khi nào

- Không thay heading/fieldset.
- Không dùng divider là decoration giữa mọi dòng.
- Không dùng rule nhạt để nhận biết input.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `orientation` | `enum` | horizontal |
| `label` | `string|null` | null |
| `decorative` | `boolean` | false |

### Ví dụ cấu hình / nội dung

```json
{
  "orientation": "horizontal",
  "label": null,
  "decorative": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Không nhận focus; không có keyboard action. Separator resize được là component khác, không giả divider tương tác.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Rule co theo container; vertical chuyển layout phù hợp khi toolbar wrap; label không tràn.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Screen reader không đọc separator dư.
- Chiều dày đúng theme.
- Labeled content không bị line đè.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[card](./card.md) · [toolbar](./toolbar.md) · [menu](./menu.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
