# Text link

Nhóm: Actions · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đi tới một route, tài nguyên hoặc vị trí nội dung. Link vẫn có affordance khi không hover.

## Cấu tạo

Text mô tả đích; optional external indicator trang trí; href hợp lệ; focus ring nhìn được; current marker khi là navigation.

## Thông số và token

Font body/small tùy đoạn; link/link-hover; underline mặc định cho link trong prose, không chỉ màu; standalone target 44px.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

inline; navigation; external; anchor. Ngoại vi mở tab mới chỉ khi có lý do và thông báo trước.

## Trạng thái và chuyển trạng thái

Default/hover/focus/visited theo chính sách app; current destination dùng aria-current, không aria-pressed. Không có loading state giả.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Khám phá bài nghe.
- Đi tới chính sách quyền riêng tư.
- Nhảy tới phần bản chép lời.

## Không được dùng khi nào

- Không dùng href rỗng cho action.
- Không dùng chữ Xem thêm lặp mà không có ngữ cảnh.
- Không ẩn nội dung chính sau link khó nhìn.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `label` | `string` | bắt buộc |
| `href` | `url` | bắt buộc |
| `external` | `boolean` | false |
| `current` | `boolean` | false |
| `newTab` | `boolean` | false |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Khám phá bài nghe",
  "href": "/lessons",
  "current": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter mở đích; browser context menu/copy address hoạt động. Space cuộn trang như native link.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Wrap theo prose; không tách icon external khỏi text. Anchor có scroll margin theo navbar/mini player.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Mở tab mới đúng browser.
- Label đích đọc rõ.
- Đường link phân biệt được không chỉ màu.
- Anchor không bị sticky header che.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[button](./button.md) · [breadcrumb](./breadcrumb.md) · [navbar](./navbar.md)

Tham khảo pattern: [APG Text link](https://www.w3.org/WAI/ARIA/apg/patterns/link/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
