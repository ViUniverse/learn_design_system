# Seek bar

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chỉnh vị trí playback trên timeline thật, dùng slider semantic; khác Progress chỉ hiển thị.

## Cấu tạo

Label; range; thumb; played/buffered/remaining layers; elapsed/total; optional preview time.

## Thông số và token

Track4–6px, thumb16–20 trong hit44, active/track; buffered không là played; timer small/tabular.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

audio range; chapter-aware optional. Unknown duration không tương tác seek.

## Trạng thái và chuyển trạng thái

Ready/scrubbing/disabled/unknown/buffering; local preview khi kéo, commit đến engine; giữ giá trị thật nếu engine seek thất bại.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Audio player full.
- Sentence review có duration.
- Long audio có timestamps.

## Không được dùng khi nào

- Không waveform decorative thay range.
- Không percent khi duration unknown.
- Không bắt drag.
- Không seek mỗi frame nếu engine không chịu được.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `elapsedSeconds` | `number` | bắt buộc |
| `durationSeconds` | `number|null` | null |
| `bufferedSeconds` | `number|null` | null |
| `disabled` | `boolean` | false |
| `onPreview` | `callback|null` | null |
| `onCommit` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "elapsedSeconds": 42,
  "durationSeconds": 300,
  "bufferedSeconds": 120,
  "disabled": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Arrow step5s đề xuất, Home0/End duration, Page step30s nếu có; native range; aria-valuetext đọc thời gian đã nghe và tổng.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Timer ngoài track, wrap khi hẹp; target44; landscape cũng còn đủ track; touch AT test bắt buộc.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Clamp0/end.
- Scrub khi playback đang chạy.
- Engine rejected seek.
- Unknown duration.
- Keyboard/touch AT.
- No per-second live spam.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[slider](./slider.md) · [waveform](./waveform.md) · [audio-player](./audio-player.md)

Tham khảo pattern: [APG Seek bar](https://www.w3.org/WAI/ARIA/apg/patterns/slider/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
