# Lesson card

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đơn vị khám phá một bài nghe, giúp quyết định nghe dựa trên chủ đề, level và thời lượng thực.

## Cấu tạo

Cover1:1; title link; level; duration; source/description optional; listen/save; download/progress optional.

## Thông số và token

Radius-card20, padding16/24, gap12/16; title h3/body theo size; body/metadata small; selected style chỉ bài thực sự selected.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

featured; catalog; compact row; continue-listening có elapsed/total thật.

## Trạng thái và chuyển trạng thái

Loading/ready/saved/downloaded/unavailable; pending save riêng; completion khác downloaded; không suy ra mastered từ đã nghe.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Catalog giúp chọn bài theo level/thời lượng.
- Gợi ý hôm nay từ dữ liệu app.
- Bài đang nghe dở có timeline thật.
- Playlist với thứ tự rõ.

## Không được dùng khi nào

- Không gán level/duration khi unknown.
- Không whole-card play lồng link/save.
- Không quá nhiều badge làm mất action chính.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `id` | `string` | bắt buộc |
| `title` | `string` | bắt buộc |
| `href` | `url` | bắt buộc |
| `level` | `string|null` | null |
| `durationSeconds` | `number|null` | null |
| `saved` | `boolean` | false |
| `onListen` | `callback` | bắt buộc |
| `onSave` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "id": "slow-mornings",
  "title": "The art of slowing down",
  "href": "/lessons/slow-mornings",
  "level": "A2",
  "durationSeconds": 300,
  "saved": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Title link đi chi tiết; Listen/Save buttons riêng. Accessible name save có title để phân biệt thẻ lặp.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Grid stack compact; featured media stack; title tối đa2 dòng với full-name access; metadata không mất.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Source unavailable.
- Saved failure rollback.
- Title long.
- Unknown duration.
- Download marker thật.
- Actions không xung đột.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[card](./card.md) · [audio-player](./audio-player.md) · [download-status](./download-status.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
