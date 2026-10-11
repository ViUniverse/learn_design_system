# Download status

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Trạng thái availability ngoại tuyến của một bài và từng asset bắt buộc, độc lập playback.

## Cấu tạo

Status label/icon; size nếu biết; progress; download/cancel/retry/remove; scope assets.

## Thông số và token

Icon20/target44, small/body text; Progress cho byte thật; Badge success chỉ complete có verification.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

inline card status; download queue row; offline banner context. Removal là action riêng với confirmation/undo phù hợp.

## Trạng thái và chuyển trạng thái

Not-downloaded/queued/downloading/paused/verifying/available/failed/removing. Available chỉ khi required audio/transcript assets đạt policy app.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lesson card.
- Offline library.
- Quản lý dung lượng.
- Retry tác vụ tải.

## Không được dùng khi nào

- Không suy ra downloaded từ cache playback.
- Không 100% rồi available trước verify.
- Không tự tải cloud dữ liệu nhạy cảm không policy.
- Không ngăn đọc transcript local khi audio lỗi.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `lessonId` | `string` | bắt buộc |
| `state` | `enum` | bắt buộc |
| `bytesLoaded` | `number|null` | null |
| `bytesTotal` | `number|null` | null |
| `assets` | `string[]` | bắt buộc |
| `onAction` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "lessonId": "slow-mornings",
  "state": "downloading",
  "bytesLoaded": 4200000,
  "bytesTotal": 10000000,
  "assets": [
    "audio",
    "transcript"
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Download/cancel/retry native; status polite chuyển meaningful, không per-byte; remove có name bài và giữ focus vào row kế khi biến mất.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Action/status stack, queue không scroll toàn page ngang; label size đọc được; banner scope toàn app tách riêng.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Partial download.
- Disk full.
- Cancel/resume/retry idempotent.
- Verifying failure.
- Offline reboot availability.
- Asset version mismatch.
- Removal state đúng.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[progress](./progress.md) · [lesson-card](./lesson-card.md) · [banner](./banner.md) · [error-state](./error-state.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
