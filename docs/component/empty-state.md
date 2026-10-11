# Empty state

Nhóm: Feedback · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Giải thích không có dữ liệu trong ngữ cảnh và đưa bước tiếp theo phù hợp.

## Cấu tạo

Optional illustration; title; description; primary/secondary action; filter context khi search.

## Thông số và token

Padding32/48, max-width480, title h3/body; icon32 decorative; không khung quá cao chiếm màn hình.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

first-use; no-results; empty-filter; cleared-library. Lỗi dùng Error state.

## Trạng thái và chuyển trạng thái

Empty chỉ sau fetch thành công; loading và error không hiển thị empty tạm; CTA pending theo Button.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Thư viện chưa có bài.
- Không tìm thấy từ.
- Filter A2 không có kết quả.

## Không được dùng khi nào

- Không dùng cho network failure.
- Không nói 0 bài khi dữ liệu unknown.
- Không CTA mua gói nếu nguyên nhân là filter chưa đúng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `kind` | `enum` | first-use |
| `title` | `string` | bắt buộc |
| `message` | `string` | bắt buộc |
| `action` | `Action|null` | null |
| `context` | `string|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "kind": "first-use",
  "title": "Chưa có bài đã lưu",
  "message": "Lưu một bài bạn muốn nghe lại.",
  "action": {
    "id": "explore",
    "label": "Khám phá bài nghe"
  }
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Heading đọc được, actions native; không autofocus cả empty block sau mọi query; result summary polite nếu cần.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Stack một cột; action có thể full width compact; copy ngắn đủ nguyên nhân nhưng không cắt.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Loading/error không nhầm empty.
- No-result giữ query.
- Clear-filter hoạt động.
- Không metric giả.
- Image decorative đúng.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[error-state](./error-state.md) · [search](./search.md) · [button](./button.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
