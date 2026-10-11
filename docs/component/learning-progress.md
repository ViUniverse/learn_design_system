# Learning progress

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tóm tắt tiến độ mục tiêu học với định nghĩa dữ liệu rõ, không khẳng định trình độ vượt bằng chứng.

## Cấu tạo

Goal label; listened minutes/target; progress; lesson count optional; period; source timestamp/stale label.

## Thông số và token

Card radius20/padding24, stat value h2, bar progress-active/track; labels body/small; không nhiều decorative badges.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

daily-goal; weekly-summary; lesson-completion. Mastery cần model riêng không nằm ở listened progress.

## Trạng thái và chuyển trạng thái

Loading/available/no-goal/unknown/stale/error; over-target vẫn giữ số thật; goal0 không division; completion app xác nhận.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Home dashboard.
- Kết thúc bài.
- Library summary.
- Mục tiêu nghe hôm nay.

## Không được dùng khi nào

- Không progress khi mẫu số unknown.
- Không xem downloaded minutes là listened.
- Không guilt streak khi bỏ ngày.
- Không fake proficiency percent.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `listenedMinutes` | `number|null` | null |
| `targetMinutes` | `number|null` | null |
| `period` | `string` | bắt buộc |
| `completedLessons` | `number|null` | null |
| `status` | `enum` | available |
| `updatedAt` | `timestamp|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "listenedMinutes": 12,
  "targetMinutes": 20,
  "period": "Hôm nay",
  "completedLessons": 2,
  "status": "available"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Display không focus, goal edit là action riêng; progress label đọc cả current/target; không live announce timer mỗi giây.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Metric stack compact; số/unit cùng nhóm; chart alternative nếu hiển thị history; text scaling giữ tất cả labels.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Unknown/zero/over-target.
- Timezone midnight.
- Offline stale.
- Listened definition.
- Goal edit.
- Text alternative số chính xác.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[stat](./stat.md) · [progress](./progress.md) · [card](./card.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
