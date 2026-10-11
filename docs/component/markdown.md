# Markdown

Nhóm: Data · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Render nội dung rich text có heading, list, link và code theo theme, giữ ngôn ngữ và giới hạn đọc.

## Cấu tạo

Semantic headings; paragraphs; lists; blockquote; links; code blocks; image policy.

## Thông số và token

Body16/1.6, reading width760/65ch, paragraph gap16; h2/h3 theo scale; link underline; code mono.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

lesson notes; help article; user note read mode. Math/HTML chỉ khi app có sanitizer và nhu cầu rõ.

## Trạng thái và chuyển trạng thái

Ready/loading/parse-error; không chạy scripts; link/image policy explicit; content update giữ scroll khi đang đọc.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Ghi chú bài nghe.
- Hướng dẫn.
- Nội dung học có cấu trúc do app cho phép.

## Không được dùng khi nào

- Không render raw HTML không tin cậy.
- Không transcript synchronized bằng Markdown parser.
- Không tự fetch remote image/URL từ văn bản riêng tư.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `content` | `string` | bắt buộc |
| `language` | `string` | vi |
| `allowHtml` | `boolean` | false |
| `onLink` | `callback` | bắt buộc |
| `imagePolicy` | `enum` | app-controlled |

### Ví dụ cấu hình / nội dung

```json
{
  "content": "## Từ mới\n- **slow down**: chậm lại",
  "language": "vi",
  "allowHtml": false,
  "imagePolicy": "app-controlled"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Links native; heading hierarchy theo page; code scroll có access khi cần; không tạo focus mọi paragraph.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Prose wrap, table/code scroll bounded; long URL break; text scaling không bị fixed max-height.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Sanitization, dangerous URL, malformed input.
- Heading hierarchy.
- Long code bounded.
- No implicit network.
- Language đọc đúng.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[code-block](./code-block.md) · [text-link](./text-link.md) · [transcript](./transcript.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
