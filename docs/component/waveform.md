# Waveform

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Lớp trực quan của biên độ âm thanh khi có dữ liệu thực; timeline seek vẫn là control chính.

## Cấu tạo

Amplitude samples; time alignment; played/unplayed marks; accessible summary hoặc decorative hidden.

## Thông số và token

Bars/line theo width, height32–64; progress-active/track; không border mark; samples downsample theo pixel.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

static audio waveform; played overlay; decorative sample phải ghi rõ chỉ minh họa.

## Trạng thái và chuyển trạng thái

Data loading/ready/unavailable; khi thiếu dữ liệu dùng track đơn giản; playing không animate ngẫu nhiên để giả audio.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Preview audio có samples.
- Full player cần hình timeline.
- Lesson art chỉ decorative có nhãn phù hợp.

## Không được dùng khi nào

- Không thay transcript.
- Không ràng buộc accessibility vào canvas.
- Không generate random bars rồi gọi waveform thật.
- Không mỗi bar là target.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `samples` | `number[]|null` | null |
| `durationSeconds` | `number|null` | null |
| `elapsedSeconds` | `number` | 0 |
| `decorative` | `boolean` | true |
| `summary` | `string|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "samples": [
    0.2,
    0.6,
    0.4,
    0.8,
    0.3
  ],
  "durationSeconds": 300,
  "elapsedSeconds": 42,
  "decorative": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Waveform không tabbable nếu display; Seek bar cung cấp phím. Nếu click waveform seek, vẫn phải có range song song.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Resample theo width, không co SVG cố định làm marks khó đọc; reduced motion không loop.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Sample-time mapping.
- Missing data fallback.
- No fake playback.
- Contrast active ngoài màu có elapsed.
- Resize không stale canvas.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[seek-bar](./seek-bar.md) · [audio-player](./audio-player.md) · [progress](./progress.md)

Tham khảo pattern: [WAI Media](https://www.w3.org/WAI/media/av/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
