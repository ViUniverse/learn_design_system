# Card

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nhóm nội dung cùng đối tượng/nhiệm vụ thành một bề mặt, không mặc định là control tương tác.

## Cấu tạo

Container; optional media; title; body; metadata; action area.

## Thông số và token

Radius-card20, padding16/24, gap16; surface/text-primary; border-subtle; no shadow mặc định.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

content; selectable; navigable. Selectable dùng radio/checkbox bên trong, navigable có link thật.

## Trạng thái và chuyển trạng thái

Static; hover chỉ navigable; selected theo lựa chọn thật; skeleton/error thuộc dữ liệu. Focus đặt ở action, không container dư.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lesson summary.
- Nhóm settings.
- Feature marketing có nội dung liên hệ.

## Không được dùng khi nào

- Không bọc từng dòng nhỏ trong card.
- Không lồng nhiều card tạo chrome.
- Không cả-card click lồng button/link làm click xung đột.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `title` | `string|null` | null |
| `content` | `slot` | bắt buộc |
| `media` | `slot|null` | null |
| `actions` | `Action[]` | rỗng |
| `selection` | `boolean|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "title": "Bài nghe hôm nay",
  "content": "Một câu chuyện ngắn về buổi sáng",
  "actions": [
    "listen"
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Container static không Tab; actions native. Nếu toàn card navigation, dùng một link chính và action phụ sibling, không nested interactive.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Padding16 compact; media stack; title xuống dòng; grid không ép card cao cố định.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Không nested interactive.
- Selected có semantic.
- Title dài fit.
- Dark surface boundary rõ.
- Loading giữ footprint.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[lesson-card](./lesson-card.md) · [topic-card](./topic-card.md) · [image](./image.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
