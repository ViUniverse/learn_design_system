# Skeleton

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Placeholder geometry cho dữ liệu đang tải, giảm layout shift mà không giả nội dung.

## Cấu tạo

Vùng busy; block ảnh; lines text; shape actions; loading label accessible duy nhất.

## Thông số và token

Background-subtle/surface-hover, radius theo content; kích thước khớp card/list dự kiến; shimmer optional.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

card; list-row; text-block. Không vẽ pixel của dữ liệu không biết trước.

## Trạng thái và chuyển trạng thái

Loading→content/error/empty; skeleton aria-hidden, vùng có aria-busy và status; reduced-motion bỏ shimmer.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Catalog lesson đầu tải.
- Lesson metadata.
- Stats có bố cục biết trước.

## Không được dùng khi nào

- Không dùng thay feedback submit nhỏ.
- Không giữ skeleton khi lỗi.
- Không animation wave nặng.
- Không fake lines đọc được.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `kind` | `enum` | card |
| `count` | `number` | 3 |
| `loadingLabel` | `string` | bắt buộc |
| `animated` | `boolean` | true |

### Ví dụ cấu hình / nội dung

```json
{
  "kind": "card",
  "count": 3,
  "loadingLabel": "Đang tải danh sách bài nghe…",
  "animated": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Không focusable, không có link giả. Nội dung thực xuất hiện không cướp focus trừ workflow cần.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Grid skeleton theo breakpoint như content; không reserve chiều cao fixed làm overflow text thật.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Không skeleton tab stops.
- Reduced-motion tĩnh.
- Loaded layout không shift lớn.
- Error/empty đúng.
- Aria-busy tắt.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[loading-indicator](./loading-indicator.md) · [lesson-card](./lesson-card.md) · [empty-state](./empty-state.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
