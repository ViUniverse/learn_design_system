# Sidebar

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Navigation ứng dụng bền vững với nhiều destination hoặc nhóm; không chứa panel nội dung chính.

## Cấu tạo

Nav landmark có label; group heading; destination links; current marker; optional collapse control.

## Thông số và token

Width256px expanded, item min44, padding16, gap8; surface/background-subtle; border-subtle phân vùng.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

expanded; compact rail khi icon đủ quen và có label access; temporary drawer compact.

## Trạng thái và chuyển trạng thái

Current route; expanded groups; collapsed; disabled destination có explanation. Active không chỉ background.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- App desktop với Khám phá/Thư viện/Từ vựng/Cài đặt.
- Nhóm route trong workspace học.

## Không được dùng khi nào

- Không làm sidebar cho landing một trang.
- Không dùng tree role nếu navigation không phải tree widget.
- Không icon-only mọi mục khó hiểu.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `NavGroup[]` | bắt buộc |
| `currentPath` | `string` | bắt buộc |
| `collapsed` | `boolean` | false |
| `onCollapse` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "currentPath": "/library",
  "collapsed": false,
  "items": [
    {
      "label": "Học",
      "links": [
        {
          "label": "Thư viện",
          "href": "/library"
        }
      ]
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab tới từng link native; group disclosure button riêng; không áp arrows menu cho link nav. Toggle collapse giữ focus.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Dưới expanded breakpoint chuyển Drawer; đóng khi route được chọn nếu transient; không giữ cột256 trên320.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Route dài đọc được.
- Current một đích.
- Drawer focus đúng.
- Collapse không mất accessible names.
- Grouped disclosure không navigate.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[navbar](./navbar.md) · [drawer](./drawer.md) · [accordion](./accordion.md)

Tham khảo pattern: [APG Landmark regions](https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
