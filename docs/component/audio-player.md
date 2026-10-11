# Audio player

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Điều khiển media session đang nghe; UI phản ánh engine state, không tự giả playback.

## Cấu tạo

Lesson identity; play/pause; seek bar; elapsed/duration; back/forward10; speed; volume/mute nếu hỗ trợ; buffering/error; transcript link.

## Thông số và token

Surface/radius-panel24, padding24/16 compact; Play56, phụ44; timeline giữ space; controls wrap theo task priority.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

full lesson; embedded preview có label nguồn; native fallback. Mini player là projection của cùng session.

## Trạng thái và chuyển trạng thái

Idle/loading/ready/playing/paused/buffering/ended/error. Play success dựa media event; buffering giữ elapsed. Source-change reset đúng bài, không theme reset.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lesson detail.
- Preview landing do người dùng khởi động.
- Nghe lại sentence qua callback session.

## Không được dùng khi nào

- Không autoplay.
- Không tạo audio session thứ hai khi mini player mở.
- Không gọi TTS là bản thu người thật.
- Không fake waveform khi buffer.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `lessonId` | `string` | bắt buộc |
| `playbackState` | `enum` | bắt buộc |
| `elapsedSeconds` | `number` | 0 |
| `durationSeconds` | `number|null` | null |
| `speed` | `number` | 1 |
| `onPlayPause` | `callback` | bắt buộc |
| `onSeek` | `callback` | bắt buộc |
| `onRetry` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "lessonId": "slow-mornings",
  "playbackState": "paused",
  "elapsedSeconds": 42,
  "durationSeconds": 300,
  "speed": 1
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Buttons native; seek range arrows/Home/End; shortcut Space chỉ khi focus player và không input, không toàn trang. Timer không live announce mỗi giây.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Compact ưu tiên play/timeline/identity; speed/volume vào popover; safe-area; transcript còn đọc khi audio lỗi.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Engine rejected play.
- Unknown duration.
- Ended restart.
- Pause/resume.
- Buffering/offline.
- Source changed.
- Focus và state giữ khi theme đổi.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[seek-bar](./seek-bar.md) · [speed-control](./speed-control.md) · [waveform](./waveform.md) · [mini-player](./mini-player.md) · [transcript](./transcript.md)

Tham khảo pattern: [WAI Media](https://www.w3.org/WAI/media/av/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
