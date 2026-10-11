# Navbar

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Navigation đầu trang cho landing hoặc app compact, gồm brand và destination chính.

## Cấu tạo

Brand link; nav landmark; destination links; optional primary CTA; menu trigger mobile; skip link.

## Thông số và token

Height tối thiểu64 mobile/72 desktop, container-wide, gutter theo breakpoint; surface với border-subtle; layer-sticky nếu sticky.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

marketing; application compact; sticky tùy ngữ cảnh. Không yêu cầu notch/glass đặc thù nguồn.

## Trạng thái và chuyển trạng thái

Current route dùng aria-current; menu expanded gắn trigger; scroll không đổi label/destination; pending route thuộc app.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Landing Vi Learn cần brand và CTA.
- Catalog mobile cần navigation compact.
- Đầu app không có sidebar nhưng vẫn có destination rõ.

## Không được dùng khi nào

- Không nhét mọi destination vào nav.
- Không dùng role menubar cho link site.
- Không dùng fixed header che hero/focus.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `brandHref` | `url` | bắt buộc |
| `links` | `NavItem[]` | bắt buộc |
| `currentPath` | `string` | bắt buộc |
| `sticky` | `boolean` | false |
| `primaryAction` | `Action|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "brandHref": "/",
  "links": [
    {
      "label": "Bài nghe",
      "href": "/lessons"
    },
    {
      "label": "Từ vựng",
      "href": "/words"
    }
  ],
  "currentPath": "/lessons"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Link Tab/Enter native; skip link hiện khi focus. Mobile menu trigger Enter/Space mở drawer, Esc đóng và trả focus.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Khi thiếu chỗ chuyển Drawer; brand/CTA chính còn nhìn được; wrap label không ép height64 cố định.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Skip link tới main.
- Current route đúng.
- Nav không che focus.
- Menu resize về desktop không để body locked.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[sidebar](./sidebar.md) · [drawer](./drawer.md) · [text-link](./text-link.md)

Tham khảo pattern: [APG Landmark regions](https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
