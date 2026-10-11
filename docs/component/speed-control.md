# Speed control

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn một tốc độ playback engine hỗ trợ, giữ nội dung đang nghe và position.

## Cấu tạo

Trigger current speed; labeled selection group; options; engine error feedback.

## Thông số và token

Trigger44, label như 1×; popup surface-raised/radius-lg; options44; radio selection pair.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

compact popover; native Select; sheet mobile. Defaults0.75/1/1.25/1.5/2 chỉ khi engine hỗ trợ.

## Trạng thái và chuyển trạng thái

Current/open/changing/failed; selection xác nhận khi engine áp dụng; option unavailable có reason; speed không đổi duration source thật.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Audio player.
- Review pronunciation.
- Settings nhớ preference cho lần sau.

## Không được dùng khi nào

- Không Slider cho enum speed.
- Không đổi position khi speed đổi.
- Không hứa giữ cao độ khi engine không hỗ trợ.
- Không reset speed theo theme.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `number` | 1 |
| `supportedRates` | `number[]` | bắt buộc |
| `onChange` | `callback` | bắt buộc |
| `changing` | `boolean` | false |
| `preservesPitch` | `boolean|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "value": 1.25,
  "supportedRates": [
    0.75,
    1,
    1.25,
    1.5,
    2
  ],
  "preservesPitch": null
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Trigger Enter/Space mở; selection theo Radio/Select; Esc trả focus; accessible label Tốc độ phát 1.25 lần, không chỉ dấu nhân.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Popover chuyển sheet khi hẹp; speed luôn đọc được trong player; options không thành cột quá dài.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Unsupported rate.
- Engine failure.
- Current speed readable.
- Session unchanged.
- Keyboard selection.
- Persisted preference hợp policy app.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[select](./select.md) · [popover](./popover.md) · [audio-player](./audio-player.md)

Tham khảo pattern: [APG Speed control](https://www.w3.org/WAI/ARIA/apg/patterns/radio/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
