# Popover

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Bề mặt thông tin hoặc control ngắn, neo vào trigger và giữ context nền sử dụng được.

## Cấu tạo

Trigger; anchored panel; optional title; content; close action nếu cần.

## Thông số và token

Surface-raised/radius-lg/shadow-md, border-subtle, padding16; width theo nội dung240–360 max viewport.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

nonmodal mặc định; interactive; informational. Modal mobile phải chuyển Dialog/Drawer và semantics đúng.

## Trạng thái và chuyển trạng thái

Closed/open/loading/error; app xác định open state; content rerender không reset focus. Outside click đóng chỉ khi không mất draft.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Speed options.
- Thông tin nguồn bài.
- Cài đặt player ngắn.
- Tra từ dùng Dictionary popover.

## Không được dùng khi nào

- Không tác vụ dài/multi-step.
- Không gọi aria-modal nếu nền tương tác.
- Không chứa confirmation nguy hiểm khó đọc trong vùng nhỏ.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `open` | `boolean` | bắt buộc |
| `title` | `string|null` | null |
| `placement` | `enum` | auto |
| `onOpenChange` | `callback` | bắt buộc |
| `content` | `slot` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "open": true,
  "title": "Tốc độ phát",
  "placement": "auto",
  "content": [
    "0.75×",
    "1×",
    "1.25×"
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Interactive mở focus tới nội dung hợp lý; Esc đóng và restore trigger. Không trap Tab cho nonmodal; focus out có policy đóng rõ.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Reposition; khi quá nhỏ chuyển sheet có title/close; không giới hạn nội dung bằng clip.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Offscreen trigger, resize/scroll.
- Esc layer đúng.
- Focus restore.
- Draft không mất.
- Background không inert khi nonmodal.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[dialog](./dialog.md) · [drawer](./drawer.md) · [dictionary-popover](./dictionary-popover.md)

Tham khảo pattern: [APG Popover](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
