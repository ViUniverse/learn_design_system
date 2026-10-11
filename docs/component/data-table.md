# Data table

Nhóm: Data · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

So sánh dữ liệu theo cột thật sự, ưu tiên HTML table với header và caption.

## Cấu tạo

Caption; column headers; rows/cells; optional sort buttons; row selection; pagination; empty/error regions.

## Thông số và token

Cell padding12/16, row min44, text14–16, border-subtle; numeric align end/tabular; header label500.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

read-only; sortable; selectable. Editable grid không nằm trong table static; cần đặc tả Grid riêng khi thật sự cần.

## Trạng thái và chuyển trạng thái

Loading/loaded/empty/error; sort direction; selected rows; unknown values dùng ký hiệu kèm nghĩa thay 0.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lịch sử học theo ngày.
- Quản trị lesson metadata.
- Export preview dữ liệu cột.

## Không được dùng khi nào

- Không cho catalog cover giàu hình nếu list/card tốt hơn.
- Không role grid chỉ để styles.
- Không sort bằng click header không button/name.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `columns` | `Column[]` | bắt buộc |
| `rows` | `Row[]` | bắt buộc |
| `caption` | `string` | bắt buộc |
| `sort` | `Sort|null` | null |
| `selectedIds` | `string[]` | rỗng |
| `onSort` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "caption": "Lịch sử nghe",
  "columns": [
    "Ngày",
    "Bài",
    "Phút nghe"
  ],
  "rows": [
    {
      "id": "1",
      "date": "2026-10-08",
      "lesson": "Slow mornings",
      "minutes": 5
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab tới sort/selection/actions; table cells static không Tab. aria-sort trên header đúng, sort button nói hướng tiếp theo.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Scroll ngang cục bộ có label khi cần data hai chiều; sticky header không che focus; không ẩn cột thiết yếu thiếu alternative.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Header associations.
- Sorted state/data đúng.
- Locale numbers.
- Narrow scroll bounded.
- Selection IDs theo page.
- Empty/error khác.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[pagination](./pagination.md) · [checkbox](./checkbox.md) · [stat](./stat.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
