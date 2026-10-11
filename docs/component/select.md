# Select

Nhóm: Forms · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn một giá trị trong tập hữu hạn; ưu tiên native select cho danh sách ngắn và lựa chọn quen thuộc.

## Cấu tạo

Form field với label bên ngoài; trigger/value hiện lựa chọn đã commit; chevron trang trí; options; helper/error liên kết field.

## Thông số và token

44px/radius-md, border-control, input-background; value body; trigger hiển thị option đã chọn không phải placeholder mơ hồ.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

native single-select; grouped options. Searchable/multiple chuyển sang Combobox hoặc Tag input.

## Trạng thái và chuyển trạng thái

Unset/selected/focused/disabled/invalid; options-loading có thông báo riêng và không đổi value thành option đầu tiên.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Ngôn ngữ UI.
- Tốc độ hỗ trợ nhiều giá trị.
- Timezone theo tập app cung cấp.

## Không được dùng khi nào

- Không dùng cho 2 lựa chọn cần xem ngay như radio.
- Không dùng menu action để chọn field value.
- Không nhét content tương tác vào option.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `string|null` | null |
| `options` | `Option[]` | bắt buộc |
| `placeholder` | `string|null` | null |
| `disabled` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "vi",
  "options": [
    {
      "value": "vi",
      "label": "Tiếng Việt"
    },
    {
      "value": "en",
      "label": "English"
    }
  ],
  "label": "Ngôn ngữ giao diện"
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Native keyboard theo nền tảng: arrows/typeahead, Enter/Space mở/chọn. Không chặn browser behavior để làm animation.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Option text wrap ở UI custom hoặc dùng native picker; không force menu vượt viewport; label luôn bên ngoài.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Value ngoài options được xử lý rõ.
- Selected không đổi do options reload.
- Native semantics.
- Menu không bị clipped.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[combobox](./combobox.md) · [radio-group](./radio-group.md) · [form-field](./form-field.md)

Tham khảo pattern: [WAI Forms](https://www.w3.org/WAI/tutorials/forms/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
