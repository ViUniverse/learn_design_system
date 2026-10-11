# Stat

Nhóm: Data · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Một chỉ số có đơn vị, kỳ đo và định nghĩa rõ, không chứa lời suy diễn vượt dữ liệu.

## Cấu tạo

Label; value; unit; period; optional comparison; source/help.

## Thông số và token

Value h2/h1 tabular; label small/body; surface nếu nằm card; gap8; không mọi metric đều purple.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

plain; comparison; unavailable. Trend dùng text và icon cùng màu semantic khi thực sự có ý nghĩa.

## Trạng thái và chuyển trạng thái

Loading/available/unknown/stale/error; zero là dữ liệu thực, unknown hiển thị Chưa có dữ liệu; cached có timestamp khi quan trọng.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Phút đã nghe tuần này.
- Số bài hoàn thành.
- Số từ đã lưu có nguồn rõ.

## Không được dùng khi nào

- Không tạo proficiency score giả.
- Không dữ liệu unknown thành0.
- Không comparison hai kỳ khác độ dài mà không giải thích.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `value` | `number|null` | null |
| `unit` | `string` | bắt buộc |
| `period` | `string` | bắt buộc |
| `status` | `enum` | available |
| `comparison` | `string|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Thời gian đã nghe",
  "value": 35,
  "unit": "phút",
  "period": "7 ngày gần đây",
  "status": "available"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Display không focus; help action native nếu có; value/label đọc thành một ý nghĩa.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Grid 1–3 cột theo width; số dài wrap hợp lý; unit không bị cắt hoặc nằm xa value.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Null/zero/large.
- Stale label.
- Locale format.
- Comparison có baseline.
- Screen reader hiểu đơn vị.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[learning-progress](./learning-progress.md) · [card](./card.md) · [skeleton](./skeleton.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
