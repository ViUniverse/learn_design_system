# Image

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Render ảnh nội dung/cover có tỷ lệ ổn định, mô tả phù hợp và fallback khi lỗi.

## Cấu tạo

Aspect-ratio frame; image; optional caption; fallback; alternative text.

## Thông số và token

1:1 lesson cover, 16:9 showcase; radius-lg/feature theo ngữ cảnh; giữ width/height trước load.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

informative; decorative; functional bên trong action có nhãn. Fit cover/contain do nội dung.

## Trạng thái và chuyển trạng thái

Loading/loaded/error; fallback giữ tỷ lệ, caption không mất; không animation mặc định.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lesson cover bổ sung chủ đề nhưng không thay title.
- Minh họa chủ đề không chứa thông tin bắt buộc.
- Screenshot demo có caption và alternative text.

## Không được dùng khi nào

- Không đặt title/error text chỉ trong ảnh.
- Không invert ảnh ở dark.
- Không alt chung kiểu Hình ảnh.
- Không tự tải remote từ nội dung không tin cậy.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `src` | `url` | bắt buộc |
| `alt` | `string` | bắt buộc |
| `ratio` | `string` | 1:1 |
| `fit` | `enum` | cover |
| `loading` | `enum` | lazy |
| `fallback` | `slot|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "src": "/assets/slow-mornings.webp",
  "alt": "",
  "ratio": "1:1",
  "fit": "cover"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Ảnh display không focus; image link nhận name từ alt/label đúng, không hai Tab stop.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Responsive srcset/sizes theo web; không lazy-load ảnh hero chính; ảnh dưới fold có thể lazy.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Broken URL/offline.
- Alt theo ngữ cảnh.
- Crop không mất nghĩa.
- Layout không shift.
- Asset có provenance.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[avatar](./avatar.md) · [lesson-card](./lesson-card.md) · [card](./card.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
