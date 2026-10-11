# Form field

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đóng gói label, control, helper và lỗi; cung cấp quan hệ semantic nhưng không chứa validation nghiệp vụ.

## Cấu tạo

Label; required/optional; control slot; helper; error; optional counter.

## Thông số và token

Label role label; label-control gap 8px; helper gap 4px; field gap 24px; error-foreground và text-secondary theo vai trò.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

standard; optional; required; group (fieldset/legend). Label ở trên mặc định.

## Trạng thái và chuyển trạng thái

Pristine không hiện lỗi; touched có thể validate; invalid có message và aria-invalid trên control; validating có status; readOnly khác disabled.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Mọi ô nhập cấu hình/người dùng.
- Nhóm radio mục tiêu học.
- Trường form có helper định dạng.

## Không được dùng khi nào

- Không thay label bằng placeholder.
- Không lồng fieldset vô nghĩa.
- Không báo lỗi duy nhất bằng toast hoặc màu viền.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `id` | `string` | bắt buộc |
| `label` | `string` | bắt buộc |
| `helper` | `string|null` | null |
| `error` | `string|null` | null |
| `required` | `boolean` | false |
| `control` | `slot` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "id": "goal",
  "label": "Mục tiêu nghe mỗi ngày",
  "helper": "Chọn số phút phù hợp với bạn",
  "required": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Label click focus control hoặc toggle native; field wrapper không nhận Tab dư. Error summary link đến control thực.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Stack label/control; error wrap đầy đủ. Không cố định chiều cao để giữ các hàng ngang thẳng.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- For/id và describedby đúng.
- Lỗi chỉ đọc một lần hợp lý.
- Helper và error không mất khi 200% text.
- Required không chỉ dấu sao.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[text-input](./text-input.md) · [radio-group](./radio-group.md) · [alert](./alert.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
