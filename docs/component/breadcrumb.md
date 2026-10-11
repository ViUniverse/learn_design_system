# Breadcrumb

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Hiển thị đường tổ tiên trong hierarchy, giúp quay lên cấp cha mà không phụ thuộc history.

## Cấu tạo

Nav landmark Breadcrumb; ordered links; separator decoration; current nonlink hoặc link aria-current.

## Thông số và token

Small14px, separator16px, gap8; link color; current text-secondary; target standalone44.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

full trail khi đủ bề ngang; collapsed middle khi quá dài với menu có nhãn Các cấp trước và đường xem từng parent.

## Trạng thái và chuyển trạng thái

Current cuối; intermediate links; collapsed expansion. Không có hover-dependent nội dung thiết yếu.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Chủ đề → Bài nghe → Chi tiết có hierarchy thật.
- Thư viện → playlist → bài khi cùng route tree.
- Parent navigation ổn định qua reload.

## Không được dùng khi nào

- Không dùng như back button.
- Không có hierarchy thực thì bỏ.
- Không tạo crumb từ mọi click người dùng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `BreadcrumbItem[]` | bắt buộc |
| `label` | `string` | Đường dẫn |
| `collapseAfter` | `number|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "items": [
    {
      "label": "Bài nghe",
      "href": "/lessons"
    },
    {
      "label": "Cuộc sống",
      "href": "/topics/life"
    },
    {
      "label": "Slow mornings"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab links; Enter navigate; separator không đọc. Menu middle theo Menu nếu có.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Wrap hoặc collapse phần giữa, luôn thấy parent gần nhất và current; không truncate không có full name.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Hierarchy đúng.
- Current đọc rõ.
- Separator hidden.
- Long title không gây page overflow.
- Collapsed links còn truy cập được.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[text-link](./text-link.md) · [menu](./menu.md) · [navbar](./navbar.md)

Tham khảo pattern: [APG Breadcrumb](https://www.w3.org/WAI/ARIA/apg/patterns/breadcrumb/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
