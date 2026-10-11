# Search

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tìm bài, chủ đề hoặc từ đã lưu; query hiển thị rõ và có trạng thái kết quả độc lập.

## Cấu tạo

Search landmark; label; search input; clear; optional submit; result count/status.

## Thông số và token

Input 44px/radius-pill hoặc md; glyph 20px, padding đủ clear target; focus-ring; count dùng small.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

submit-search; instant-search (debounce app 250–400ms); suggestion-search dùng Combobox.

## Trạng thái và chuyển trạng thái

Idle/query/loading/results/no-results/error. Kết quả cũ không được giả thành mới; stale request không ghi đè query hiện tại.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Catalog nhiều lesson.
- Vocabulary library.
- Tìm topic bằng tên.

## Không được dùng khi nào

- Không thay filter level.
- Không gọi network từng phím không kiểm soát.
- Không tự navigate khi người dùng đang gõ IME.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `query` | `string` | bắt buộc |
| `placeholder` | `string` | tìm kiếm |
| `status` | `enum` | idle |
| `resultCount` | `number|null` | null |
| `onQueryChange` | `callback` | bắt buộc |
| `onSubmit` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "query": "morning",
  "status": "results",
  "resultCount": 6,
  "label": "Tìm bài nghe"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter search trong submit mode; Esc đóng suggestion trước rồi có thể clear nếu quy định rõ; clear giữ focus input.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Full-width compact; result count xuống dòng ngoài input; không che field bởi keyboard.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- IME/debounce không mất ký tự.
- Hủy request cũ.
- No-results có bước tiếp theo.
- Loading count không đọc liên tục.
- Clear hoạt động bằng keyboard.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[text-input](./text-input.md) · [combobox](./combobox.md) · [empty-state](./empty-state.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
