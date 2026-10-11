# Pagination

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đi qua các trang của tập kết quả hữu hạn và giữ context filter/sort.

## Cấu tạo

Previous/next; current page; optional page numbers; result range/count; nav label.

## Thông số và token

Control44, gap8; selected pair/current marker; count small; không dùng dot-only.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

numbered; previous-next; compact. Load more là pattern riêng với append rõ.

## Trạng thái và chuyển trạng thái

First/last disable đúng; loading page giữ cũ hoặc skeleton có context; error có retry không reset filters.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Catalog dài.
- Bảng dữ liệu.
- Lịch sử học có số trang/tổng thực.

## Không được dùng khi nào

- Không hiển thị total giả khi không biết.
- Không dùng cho carousel media.
- Không tự reset về page1 khi theme đổi.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `page` | `number` | bắt buộc |
| `pageCount` | `number|null` | null |
| `resultRange` | `string|null` | null |
| `loading` | `boolean` | false |
| `onPageChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "page": 2,
  "pageCount": 8,
  "resultRange": "Bài 13–24 trong 96 bài"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab links/buttons, Enter action; aria-current=page; page change focus về heading/results nếu navigation thực và policy rõ.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Compact prev/current/next trên mobile; không thu page targets. Status đọc được khi count dài.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Boundary và page out-of-range.
- Filters giữ.
- Retry đúng page.
- Selected page được đọc.
- Async không focus lại mỗi update.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[data-table](./data-table.md) · [search](./search.md) · [text-link](./text-link.md)

Tham khảo pattern: [APG Landmark regions](https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
