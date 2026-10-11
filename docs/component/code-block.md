# Code block

Nhóm: Data · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Hiển thị đoạn mã/nguyên văn kỹ thuật có thể copy trong docs/help, không thực thi nội dung.

## Cấu tạo

Pre/code; optional language label; copy button; horizontal scroll; copy status.

## Thông số và token

Mono14/1.5, padding16, radius-md, background-subtle/text-primary/border-subtle; syntax colors phải kiểm tra trên theme.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

plain; highlighted; line-numbers chỉ khi cần tham chiếu. Copy không gồm decoration/line numbers.

## Trạng thái và chuyển trạng thái

Ready/copied/copy-failed; code text giữ nguyên newline; copy success từ clipboard API confirmation.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Hướng dẫn tích hợp.
- Config mẫu.
- Nội dung kỹ thuật trong tài liệu.

## Không được dùng khi nào

- Không cho prose thường.
- Không chạy code nhận từ nội dung.
- Không copy secret âm thầm.
- Không syntax mờ khó đọc.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `code` | `string` | bắt buộc |
| `language` | `string|null` | null |
| `showCopy` | `boolean` | true |
| `wrap` | `boolean` | false |
| `onCopy` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "code": "theme: dark",
  "language": "yaml",
  "showCopy": true,
  "wrap": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Copy button Enter/Space có name; scroll region chỉ nhận focus khi overflow cần dùng keyboard; status polite.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Scroll ngang trong block, không page; optional wrap preserving semantics; copy luôn accessible.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Copy exact text.
- Failure feedback.
- HTML escapes.
- Syntax contrast.
- Overflow không kéo trang.
- No executable code.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[markdown](./markdown.md) · [button](./button.md) · [toast](./toast.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
