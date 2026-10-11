# Accordion

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Mở/đóng các phần nội dung phụ có tiêu đề rõ, giảm chiều dài nhưng vẫn khám phá được.

## Cấu tạo

Heading; disclosure button; chevron/plus; content region; border.

## Thông số và token

Trigger min56/FAQ68–74, padding16/24, radius-lg/card; border-subtle; open selected/background-subtle nhẹ.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

single-open mặc định FAQ theo nguồn; multiple-open cho nội dung độc lập; plain disclosure một item.

## Trạng thái và chuyển trạng thái

Collapsed/expanded/focused; loading/error trong content; state không reset khi theme đổi; hidden controls không tabbable.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- FAQ landing với câu hỏi độc lập.
- Hướng dẫn học phụ người dùng có thể mở khi cần.
- Nhóm settings nâng cao không chứa lỗi bắt buộc phải đọc.

## Không được dùng khi nào

- Không giấu instruction bắt buộc hoặc lỗi form.
- Không collapse transcript đang đọc theo timer.
- Không tạo accordion chỉ vì title dài.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `AccordionItem[]` | bắt buộc |
| `openIds` | `string[]` | bắt buộc |
| `multiple` | `boolean` | false |
| `onToggle` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "multiple": false,
  "openIds": [
    "offline"
  ],
  "items": [
    {
      "id": "offline",
      "title": "Có thể nghe ngoại tuyến không?",
      "content": "Có, với bài đã tải."
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Enter/Space toggle; Tab native; optional arrows giữa headers chỉ khi triển khai trọn pattern. aria-expanded/controls gắn đúng content.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Một cột; heading wrap; animation đo height thực; expanded content không clip focus.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Single-open đóng item cũ.
- Focus không mất.
- Title/content IDs.
- Reduced-motion.
- Content nhiều dòng và zoom không cắt.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[tabs](./tabs.md) · [card](./card.md) · [navbar](./navbar.md)

Tham khảo pattern: [APG Accordion](https://www.w3.org/WAI/ARIA/apg/patterns/accordion/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
