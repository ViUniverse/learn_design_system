# Avatar

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đại diện một người/tài khoản, với fallback rõ khi thiếu ảnh.

## Cấu tạo

Image; initials/icon fallback; optional status ngoài ảnh; accessible name khi có nghĩa riêng.

## Thông số và token

Size32/40/56px, circle; image fit cover; fallback selected pair; không là touch target nếu chỉ display.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

image; initials; anonymous. Status dùng icon/label khi cần, không chỉ dot màu.

## Trạng thái và chuyển trạng thái

Loading/loaded/error; fallback không nhảy size; interactive profile dùng link/button ngoài đúng semantics.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Header tài khoản.
- Tác giả bài có danh tính thực.
- Thành viên playlist cộng tác.

## Không được dùng khi nào

- Không dùng làm cover lesson.
- Không hiển thị ảnh/tên người giả.
- Không thêm accessible name đọc lặp khi tên ở cạnh.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `name` | `string` | bắt buộc |
| `src` | `url|null` | null |
| `size` | `enum` | 40 |
| `decorative` | `boolean` | false |
| `status` | `string|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "name": "Linh Nguyễn",
  "src": null,
  "size": 40
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Static avatar không Tab; profile action là native link/button có name; ảnh không là control riêng.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Không co dưới32 khi name dài; label cạnh wrap; initials hỗ trợ dấu Việt/Unicode theo app.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Ảnh lỗi fallback.
- Initials đúng grapheme.
- Alt không lặp.
- Dark contrast.
- Clickable target44.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[avatar-group](./avatar-group.md) · [image](./image.md) · [text-link](./text-link.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
