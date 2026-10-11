# Radio group

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn duy nhất một giá trị và xem các lựa chọn cùng lúc; phù hợp tập nhỏ.

## Cấu tạo

Fieldset/legend cho toàn nhóm; radio item; label tappable; optional description giải thích lựa chọn; selected marker.

## Thông số và token

Glyph 20px/target44, gap12; group gap8–12; selected primary; focus tách selection.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

vertical mặc định; horizontal ngắn; card-radio có label/description nhưng giữ semantics.

## Trạng thái và chuyển trạng thái

Unselected/selected/focused/disabled/invalid. Không tự thay selected khi reorder; default do app cung cấp.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Mục tiêu 5/10/20 phút.
- Chọn chế độ theme system/light/dark.
- Chọn mức trình độ onboarding.

## Không được dùng khi nào

- Không dùng cho multi-select.
- Không quá nhiều option gây dài trang.
- Không áp radio semantics cho tab panel.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `string|null` | null |
| `options` | `Option[]` | bắt buộc |
| `label` | `string` | bắt buộc |
| `disabled` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "10",
  "label": "Mục tiêu hằng ngày",
  "options": [
    {
      "value": "5",
      "label": "5 phút"
    },
    {
      "value": "10",
      "label": "10 phút"
    },
    {
      "value": "20",
      "label": "20 phút"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Tab vào selected hoặc item đầu; arrows đổi focus/selection theo native radio group; Space chọn. Không có nhiều Tab stop cho custom composite.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Stack dọc khi label dài; card-radio nở theo text; không clamp description quyết định.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Chỉ một value checked.
- Arrows hợp lý.
- External value phản ánh đúng.
- Error group gắn legend.
- Label dài không cắt.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[select](./select.md) · [segmented-control](./segmented-control.md) · [checkbox](./checkbox.md)

Tham khảo pattern: [APG Radio group](https://www.w3.org/WAI/ARIA/apg/patterns/radio/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
