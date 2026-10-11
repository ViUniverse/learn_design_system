# Date picker

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn ngày theo lịch khi cần, vẫn có đường nhập text theo định dạng rõ.

## Cấu tạo

Form field; date input; open-calendar button; month/year nav; day grid; today/selected markers.

## Thông số và token

Input44/radius-md; popup surface-raised/radius-panel; day target44; today marker khác selected; focus-ring.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

native date; custom calendar khi có yêu cầu cụ thể; min/max bounds do app định nghĩa.

## Trạng thái và chuyển trạng thái

Unset/selected/open/invalid/out-of-range/disabled; displayed month không thay value đã chọn.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Chọn ngày mục tiêu.
- Filter activity theo một ngày.
- Lên lịch nhắc học với date thực.

## Không được dùng khi nào

- Không dùng để chọn duration nghe.
- Không dùng calendar cho ngày sinh nếu nhập text nhanh hơn.
- Không bắt người dùng click hàng trăm tháng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `ISO-date|null` | null |
| `min` | `ISO-date|null` | null |
| `max` | `ISO-date|null` | null |
| `locale` | `string` | vi |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "2026-10-08",
  "min": "2026-01-01",
  "locale": "vi",
  "label": "Ngày bắt đầu"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Native theo OS. Custom: arrows ngày, Home/End tuần, PageUp/Down tháng, Enter chọn, Esc đóng/restore trigger. Calendar có heading tháng được đọc; grid/day có name ngày đầy đủ, selected/disabled rõ và roving focus; mở calendar focus ngày đã chọn hoặc hôm nay trong bounds.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Mobile dùng native picker hoặc modal calendar; không cắt tuần cuối; date parsing theo locale rõ.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Leap day, min/max, locale parse, DST không làm đổi date-only.
- Focus sau đóng.
- Không chọn ngày disabled.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[date-range-picker](./date-range-picker.md) · [dialog](./dialog.md) · [form-field](./form-field.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
