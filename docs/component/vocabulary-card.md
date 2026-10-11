# Vocabulary card

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Biểu diễn một mục từ/phrase đã lưu cùng nghĩa và câu nguồn để học trong ngữ cảnh.

## Cấu tạo

Word/phrase; pronunciation optional; meaning; example; source lesson link; save/review actions; status.

## Thông số và token

Radius-card20, padding16/24; word h3; meaning body; example selected-background nhẹ/text-primary; actions44.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

compact library; expanded detail; in-lesson saved word. Không đồng nhất card với quiz review.

## Trạng thái và chuyển trạng thái

Loading/ready/saved/pending-save/error; pronunciation unavailable không có button giả; duplicate save được nhận biết.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Vocabulary library.
- Từ đã chọn trong lesson.
- Danh sách ôn tập có context.

## Không được dùng khi nào

- Không một từ rời bỏ ngữ cảnh khi có câu nguồn.
- Không nghĩa AI chưa xác nhận coi như từ điển chắc chắn.
- Không đánh mastery chỉ từ bookmark.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `id` | `string` | bắt buộc |
| `term` | `string` | bắt buộc |
| `meaning` | `string` | bắt buộc |
| `example` | `string|null` | null |
| `sourceHref` | `url|null` | null |
| `pronunciation` | `string|null` | null |
| `saved` | `boolean` | false |
| `onSave` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "id": "slow-down",
  "term": "slow down",
  "meaning": "chậm lại, giảm nhịp độ",
  "example": "We need to slow down.",
  "sourceHref": "/lessons/slow-mornings",
  "saved": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Actions/link native; pronounce có label Đọc từ [term]; không đọc IPA sai ngôn ngữ; card không Tab dư.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Stack fields; term/phrase dài wrap; source title không mất; actions wrap; translation language đúng.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Missing pronunciation.
- Long phrase.
- Saved persistence failure.
- Duplicate term contexts.
- Source removed fallback.
- Language correct.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[dictionary-popover](./dictionary-popover.md) · [review-card](./review-card.md) · [text-link](./text-link.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
