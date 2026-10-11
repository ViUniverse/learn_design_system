# Switch

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Bật/tắt một cài đặt nhị phân có hiệu lực ngay và có thể đảo lại.

## Cấu tạo

Label cố định; track/thumb; optional description; pending/error gần control.

## Thông số và token

Track visual 40×24px trong target44; off border-control/surface; on primary, thumb on-primary; focus-ring quanh target.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

standard; with-description khi cần giải thích hiệu lực. Không có mixed state hoặc trạng thái thứ ba trong switch.

## Trạng thái và chuyển trạng thái

Off/on/focus/disabled/pending; request lỗi quay về giá trị được xác nhận và báo lỗi; không đổi label thành Bật/Tắt mơ hồ.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Theo dõi đoạn đang nghe.
- Hiển thị bản dịch.
- Giảm chuyển động trong app.

## Không được dùng khi nào

- Không dùng cho thao tác cần submit form mà chưa giải thích.
- Không dùng cho đồng ý điều khoản.
- Không dùng cho nhiều hơn hai trạng thái.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `checked` | `boolean` | bắt buộc |
| `label` | `string` | bắt buộc |
| `pending` | `boolean` | false |
| `disabled` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "checked": true,
  "label": "Hiển thị bản dịch",
  "pending": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Space toggle; Enter nếu native button switch; aria-checked phản ánh trạng thái; label không đổi giữa on/off.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Label và switch hai cột khi đủ chỗ, description xuống dòng; vùng chạm không cạnh tranh cả-row action.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Chỉ một action mỗi toggle.
- Failed persistence không giả thành công.
- Focus vẫn thấy.
- State được đọc bằng screen reader.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[checkbox](./checkbox.md) · [radio-group](./radio-group.md) · [form-field](./form-field.md)

Tham khảo pattern: [APG Switch](https://www.w3.org/WAI/ARIA/apg/patterns/switch/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
