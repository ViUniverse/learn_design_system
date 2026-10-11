# Loading indicator

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Cho biết tác vụ chưa xong khi chưa có tỷ lệ tiến độ thật, với lời mô tả ngữ cảnh.

## Cấu tạo

Spinner hoặc static busy glyph; text status; aria-busy của vùng; cancel khi có hỗ trợ.

## Thông số và token

Glyph16/20, gap8, text small/body; dùng link/text-secondary theo nền, không overlay toàn trang cho tác vụ nhỏ.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

inline; button-pending; region-loading. Tác vụ dài có status/cancel thay spinner đơn độc.

## Trạng thái và chuyển trạng thái

Pending/timeout/error/complete; trạng thái complete không duy trì spinner; reduced motion static nhưng label vẫn rõ.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Đang tải audio chưa biết tổng byte.
- Validate request.
- Loading panel nhỏ.

## Không được dùng khi nào

- Không fake percentage.
- Không spinner vĩnh viễn.
- Không thay skeleton khi geometry nội dung đã biết.
- Không báo buffer như loading cả lesson.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `size` | `enum` | 20 |
| `busy` | `boolean` | true |
| `cancel` | `Action|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Đang tải bài nghe…",
  "busy": true,
  "size": 20
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Display indicator không Tab; cancel button accessible; live region chỉ báo bắt đầu/kết quả không theo frame animation.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Label wrap; giữ button width; không chặn main navigation nếu chỉ vùng nhỏ pending.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Reduced motion.
- Timeout fallback.
- Busy region đúng.
- Status không đọc lặp.
- Cancel/reset cleanup.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[skeleton](./skeleton.md) · [progress](./progress.md) · [audio-player](./audio-player.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
