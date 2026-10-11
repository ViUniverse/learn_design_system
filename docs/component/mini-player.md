# Mini player

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Điều khiển session đang hoạt động khi người dùng xem màn hình khác, không sở hữu engine riêng.

## Cấu tạo

Lesson identity/link; play/pause; compact progress; optional close/dismiss; open full player.

## Thông số và token

Min-height72 cộng safe-area, surface-raised/border-subtle, layer-sticky; target44; body padding-bottom tính chiều cao thật.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

bottom bar; desktop compact rail. Không tự hiện khi chưa có session.

## Trạng thái và chuyển trạng thái

Hidden/playing/paused/buffering/error; dismiss UI không tự xóa tiến độ; stop action cần ý nghĩa rõ.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Đi từ lesson sang vocabulary trong khi nghe.
- Mở thư viện mà vẫn điều khiển được session.

## Không được dùng khi nào

- Không che CTA/form error/focus.
- Không khởi tạo playback thứ hai.
- Không đóng player đồng nghĩa xóa lịch sử.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `sessionId` | `string` | bắt buộc |
| `title` | `string` | bắt buộc |
| `state` | `enum` | bắt buộc |
| `progress` | `number|null` | null |
| `onOpen` | `callback` | bắt buộc |
| `onPlayPause` | `callback` | bắt buộc |
| `onDismiss` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "sessionId": "session-1",
  "title": "The art of slowing down",
  "state": "playing",
  "progress": 0.4
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab buttons/link theo DOM; title opens full player; close accessible name phân biệt Tạm dừng/Đóng thanh; không shortcut global conflict.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Title1–2 dòng, tăng height khi scale; compact chỉ identity/play; content scroll padding tránh bar; keyboard mobile có policy.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Full/mini state đồng bộ.
- Sticky không che focus.
- Dismiss behavior rõ.
- Safe-area.
- Route change không restart.
- Error fallback.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[audio-player](./audio-player.md) · [progress](./progress.md) · [navbar](./navbar.md)

Tham khảo pattern: [WAI Media](https://www.w3.org/WAI/media/av/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
