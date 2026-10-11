# Tabs

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Đổi các panel cùng cấp trong một ngữ cảnh; mỗi tab gắn với một panel có nội dung riêng.

## Cấu tạo

Tablist có label; tab; active marker; tabpanel gắn ID; optional loading panel.

## Thông số và token

Tab target44, gap24, text label, marker2px; selected link/text-primary, rail border-subtle.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

text tabs; contained tabs. Manual activation mặc định nếu panel có network/latency.

## Trạng thái và chuyển trạng thái

Selected khác focused; loading/error thuộc panel; tab disabled hiếm và có lý do. Không render panel ẩn trong tab order.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Bài nghe/Bản chép lời/Ghi chú.
- Thư viện Bài đã lưu/Từ vựng.
- Panel settings cùng ngữ cảnh.

## Không được dùng khi nào

- Không thay navigation giữa route độc lập.
- Không chọn preference value.
- Không biến mọi filter thành tab.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `items` | `Tab[]` | bắt buộc |
| `activeId` | `string` | bắt buộc |
| `activation` | `enum` | manual |
| `orientation` | `enum` | horizontal |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "activeId": "transcript",
  "activation": "manual",
  "items": [
    {
      "id": "audio",
      "label": "Bài nghe"
    },
    {
      "id": "transcript",
      "label": "Bản chép lời"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab vào selected tab; arrows di chuyển roving focus; Home/End đầu/cuối; Enter/Space activate manual. Panel có aria-labelledby, hidden panel inert.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Nhiều tab có scroll cục bộ được nhận biết hoặc chuyển select với cùng value; không che active tab; nội dung panel wrap.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Arrows không tải network ở manual.
- Hidden panel không tabbable.
- Async panel không mất focus.
- ID pair chính xác.
- Selected và focus đều rõ.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[segmented-control](./segmented-control.md) · [navbar](./navbar.md)

Tham khảo pattern: [APG Tabs](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
