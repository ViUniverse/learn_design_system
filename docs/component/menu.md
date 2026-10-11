# Menu

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Danh sách action tạm thời từ một trigger, như đổi tên/xóa playlist; không phải danh sách link site.

## Cấu tạo

Menu button; popup menu; items; optional separator; checkbox/radio menu item chỉ khi có semantics tương ứng.

## Thông số và token

Trigger44; popup surface-raised/radius-lg/shadow-md; item44/padding12; danger item error-foreground.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

action menu; checked preference action. Submenu tối đa một tầng và tránh trên mobile.

## Trạng thái và chuyển trạng thái

Closed/open/active item/disabled; pending action do app xử lý sau commit; menu đóng khi action thành công hoặc dialog mở.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Overflow lesson row.
- Playlist actions.
- Sắp xếp dưới action trigger rõ.

## Không được dùng khi nào

- Không thay Select field value.
- Không role menu cho navbar.
- Không giấu action chính Nghe dưới overflow.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `MenuItem[]` | bắt buộc |
| `open` | `boolean` | false |
| `label` | `string` | bắt buộc |
| `onOpenChange` | `callback` | bắt buộc |
| `onAction` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Tùy chọn playlist",
  "items": [
    {
      "id": "rename",
      "label": "Đổi tên"
    },
    {
      "id": "delete",
      "label": "Xóa playlist",
      "tone": "danger"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter/Space/Down mở; arrows, Home/End, typeahead điều hướng; Enter action; Esc đóng trả trigger; Tab thoát/đóng theo pattern.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Popup reposition trong viewport, max height có scroll; mobile có thể action sheet với cùng items.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Focus không vào separator.
- Disabled không action.
- Esc trả focus.
- Menu trong dialog cùng focus scope.
- Danger mở xác nhận nếu cần.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[select](./select.md) · [popover](./popover.md) · [dialog](./dialog.md)

Tham khảo pattern: [APG Menu](https://www.w3.org/WAI/ARIA/apg/patterns/menu-button/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
