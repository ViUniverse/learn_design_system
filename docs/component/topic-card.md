# Topic card

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đại diện chủ đề để khám phá bài nghe hoặc lựa chọn sở thích, hai ý định có semantics khác nhau.

## Cấu tạo

Topic illustration/icon; name; optional summary/count; link hoặc checkbox rõ.

## Thông số và token

Radius-card20, padding16/24, glyph32, title h3/body; decoration peach/lavender, chữ text-primary.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

navigation topic; selectable interest. Không dùng cùng lúc link và whole-card checkbox.

## Trạng thái và chuyển trạng thái

Ready/selected/loading/disabled; lesson count unknown bỏ hoặc nói chưa có dữ liệu; selection có check và label.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Trang khám phá chủ đề.
- Onboarding sở thích.
- Filter topic từ catalog.

## Không được dùng khi nào

- Không dùng cho bài cụ thể.
- Không giả số bài.
- Không màu category là code level hoặc success.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `id` | `string` | bắt buộc |
| `title` | `string` | bắt buộc |
| `intent` | `enum` | navigate |
| `href` | `url|null` | null |
| `count` | `number|null` | null |
| `selected` | `boolean` | false |
| `onSelect` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "id": "daily-life",
  "title": "Cuộc sống hằng ngày",
  "intent": "navigate",
  "href": "/topics/daily-life",
  "count": 12
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Navigate dùng link/Enter; select dùng checkbox/Space và group legend. Không thêm roving nếu không composite.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

2 cột khi tên đủ ngắn,1 nếu hẹp/scale; description wrap; target chọn không chồng thẻ.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Intent semantics đúng.
- Selected persist.
- No fake counts.
- Decorative icon hidden.
- Title và count đọc có nghĩa.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[lesson-card](./lesson-card.md) · [checkbox](./checkbox.md) · [image](./image.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
