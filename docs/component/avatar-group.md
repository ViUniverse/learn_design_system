# Avatar group

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tóm tắt một nhóm người có danh tính thật, kèm số overflow và đường xem danh sách.

## Cấu tạo

Overlapping avatars; +N overflow; optional group label; member list action.

## Thông số và token

Avatar32/40, overlap8; viền surface2px; overflow target44 nếu click; text-primary/selected pair.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

compact summary; actionable overflow. Group không đại diện tiến độ hoặc bài nghe.

## Trạng thái và chuyển trạng thái

Loaded/partial/loading; overflow count thật; unknown total không giả +N; focus trên overflow riêng.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Playlist cộng tác.
- Nhóm học đã có tính năng.
- Attribution nhiều tác giả.

## Không được dùng khi nào

- Không thêm social proof giả vào landing.
- Không dùng cho 2 lesson cover.
- Không cho mỗi avatar chồng hit region nhau.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `members` | `Person[]` | bắt buộc |
| `visibleCount` | `number` | 4 |
| `total` | `number|null` | null |
| `label` | `string` | bắt buộc |
| `onShowAll` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "members": [
    {
      "name": "Linh"
    },
    {
      "name": "An"
    }
  ],
  "visibleCount": 2,
  "total": 5,
  "label": "Thành viên nhóm học"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Display avatars không tabbable; overflow button mở list/drawer có title; Tab không đi qua targets chồng nhau.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Giảm visibleCount trước khi nhỏ glyph; full list vẫn accessible; name tooltip chỉ bổ sung.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Count/overflow nhất quán.
- Tên đọc được qua danh sách.
- Error ảnh không đổi số.
- Không duplicate announce mỗi avatar.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[avatar](./avatar.md) · [drawer](./drawer.md) · [list](./list.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
