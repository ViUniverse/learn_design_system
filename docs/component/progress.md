# Progress

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tiến độ tác vụ có tổng biết được hoặc trạng thái đang tiến hành, không cho chỉnh giá trị.

## Cấu tạo

Label; bar; current/total hoặc percentage; optional detail/cancel.

## Thông số và token

Track4–8px progress-track; fill progress-active; radius-pill; value text small/body; không border trang trí trên bar.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

determinate; indeterminate. Circular chỉ khi tiết kiệm chỗ và vẫn có text value.

## Trạng thái và chuyển trạng thái

Unknown/pending/progress/complete/failed; failed giữ số thật và action; không fake 100% trước app xác nhận.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Download byte progress.
- Bước xử lý asset có tổng rõ.
- Phần trăm goal nghe.

## Không được dùng khi nào

- Không slider seek.
- Không meter mức proficiency suy đoán.
- Không coi task elapsed là % khi không biết tổng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `number|null` | null |
| `max` | `number` | 100 |
| `label` | `string` | bắt buộc |
| `valueText` | `string|null` | null |
| `status` | `enum` | pending |

### Ví dụ cấu hình / nội dung

```json
{
  "value": 42,
  "max": 100,
  "label": "Đang tải bài nghe",
  "valueText": "42 phần trăm",
  "status": "progress"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Progress display không Tab; role progressbar với min/max/value khi determinate; không aria-valuenow indeterminate; cancel riêng.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Label/value wrap ngoài bar; minimum bar length hợp lý; value over max clamp visual nhưng giữ nghĩa dữ liệu.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Unknown/max0/overmax.
- Screen reader không spam per-byte.
- Failed chưa complete.
- Contrast active/track/bề mặt theo vai trò.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[seek-bar](./seek-bar.md) · [download-status](./download-status.md) · [learning-progress](./learning-progress.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
