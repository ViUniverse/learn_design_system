# Badge

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nhãn ngắn mô tả metadata hoặc trạng thái, mặc định không thực thi hành động.

## Cấu tạo

Text; optional icon; soft fill; không có close button trừ khi chuyển chip control khác.

## Thông số và token

Small/caption12–14, padding4/8, radius-sm/pill; semantic pair cho status, selected pair cho topic.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

neutral; topic; success; warning; error; info. CEFR có text A1–C2, không suy ra từ màu.

## Trạng thái và chuyển trạng thái

Static state label; updated khi dữ liệu xác nhận; không focus/hover action giả.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Level A2 trong metadata bài nghe.
- Đã tải sau asset verification.
- Mới có định nghĩa thời gian thật.
- Trạng thái xử lý của file upload.

## Không được dùng khi nào

- Không thay button/filter chip.
- Không viết câu dài trong badge.
- Không chỉ dot màu hoặc số không đơn vị.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `tone` | `enum` | neutral |
| `icon` | `icon-id|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "A2",
  "tone": "neutral",
  "icon": null
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Không nhận Tab nếu display. Nếu chọn topic thì dùng button/checkbox, không nâng badge bằng onClick.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Wrap nhóm badges; label không co nhỏ; hạn chế tối đa vài badge quan trọng trên card.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Đọc rõ không màu.
- Không action ẩn.
- Trạng thái đồng bộ dữ liệu.
- Contrast từng tone.
- Text không overflow.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[topic-card](./topic-card.md) · [lesson-card](./lesson-card.md) · [checkbox](./checkbox.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
