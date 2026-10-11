# List / List item

Nhóm: Data · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Hiển thị tập mục dễ quét theo thứ tự hoặc nhóm, với action rõ trên từng item.

## Cấu tạo

List semantic; optional group heading; item leading media; title; metadata; main action; trailing action.

## Thông số và token

Row min56/72 tùy media, padding12/16, gap12; separator border-subtle optional; title body/label; metadata small.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

static list; linked items; selectable checkbox list. Virtualized chỉ khi cần và vẫn giữ semantics/focus.

## Trạng thái và chuyển trạng thái

Loading/loaded/empty/error; selected riêng khi batch mode; disabled action không làm cả row mờ vô nghĩa.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Playlist lessons.
- Saved words compact.
- File upload queue.
- Settings destinations.

## Không được dùng khi nào

- Không grid role cho list thường.
- Không entire-row click lồng nhiều actions.
- Không virtualize tập ít làm mất đọc screen reader.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `ListItem[]` | bắt buộc |
| `ordered` | `boolean` | false |
| `selection` | `string[]|null` | null |
| `onSelect` | `callback|null` | null |
| `emptyMessage` | `string|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "ordered": false,
  "items": [
    {
      "id": "lesson-1",
      "title": "Slow mornings",
      "metadata": "A2 · 5 phút",
      "href": "/lessons/lesson-1"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab tới actions/links native; static text không Tab. Checkbox selection theo native, không tự thêm arrows toàn list.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Title và metadata stack; trailing action giữ44; hàng nở theo label; dùng lesson-card khi cần cover lớn.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Stable item IDs.
- Duplicate title still distinct actions.
- Loading state đúng.
- Virtualization focus không rơi.
- Long titles fit.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[lesson-card](./lesson-card.md) · [checkbox](./checkbox.md) · [empty-state](./empty-state.md)

Tham khảo pattern: [Quyết định thiết kế Vi Learn](../MASTER.md). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
