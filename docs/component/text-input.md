# Text input

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nhập một giá trị văn bản một dòng; loại dữ liệu và autocomplete do app quyết định.

## Cấu tạo

Form field; input; optional prefix/suffix; optional clear button; helper/error.

## Thông số và token

Min-height 44px, padding 12px/16px, radius-md, input-background/text-primary, border-control; placeholder dùng text-placeholder.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

text; email; password; numeric-text. Prefix/suffix chỉ khi nghĩa rõ; password reveal có name riêng.

## Trạng thái và chuyển trạng thái

Empty/filled; focus; readOnly vẫn copy; disabled; invalid; pending validation. Không xóa value khi server lỗi.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Tên playlist.
- Email tài khoản.
- Mục tiêu nhập dạng số có constraint rõ.

## Không được dùng khi nào

- Không cho văn bản nhiều dòng.
- Không dùng number input cho số điện thoại/ID có số 0 đầu.
- Không dùng mask phá paste/IME.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `string` | bắt buộc |
| `type` | `enum` | text |
| `autocomplete` | `string|null` | null |
| `inputMode` | `string|null` | null |
| `readOnly` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "Nghe buổi sáng",
  "type": "text",
  "autocomplete": "off",
  "label": "Tên playlist"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Giữ thao tác caret/select/copy native. Enter chỉ submit khi thuộc form hợp lệ; clear button có Tab/name riêng.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Font input 16px; full-width theo form container; suffix không che text. Mobile keyboard theo inputMode.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Paste, dấu Việt và IME.
- External value cập nhật đúng.
- Readonly khác disabled.
- Clear không mất focus.
- Type password không log secret.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[form-field](./form-field.md) · [textarea](./textarea.md) · [search](./search.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
