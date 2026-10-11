# Segmented control

Nhóm: Navigation · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Chọn một giá trị trong 2–5 lựa chọn ngắn, tác động tới cùng nội dung hoặc cài đặt.

## Cấu tạo

Group label mô tả giá trị; rail; option buttons/radios; selected fill và text/icon marker; focus riêng của option.

## Thông số và token

Rail radius-pill, padding4; option min44 cho touch; track background-subtle/border-subtle; selected selected pair.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

single-value radio semantics; multi-value chỉ khi product quy định rõ và dùng checkbox semantics.

## Trạng thái và chuyển trạng thái

Unselected/selected/focused/disabled; selection không ẩn control khác; value do app quản lý.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lọc Tất cả/Đã tải.
- Theme Sáng/Tối/Hệ thống.
- Chọn chế độ đọc nếu chỉ đổi giá trị.

## Không được dùng khi nào

- Không dùng cho nhiều panel có semantics tab.
- Không cho label dài hoặc quá 5 option.
- Không dùng để điều hướng nhiều tầng.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `value` | `string` | bắt buộc |
| `options` | `Option[]` | bắt buộc |
| `label` | `string` | bắt buộc |
| `disabled` | `boolean` | false |
| `onChange` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "value": "downloaded",
  "label": "Phạm vi thư viện",
  "options": [
    {
      "value": "all",
      "label": "Tất cả"
    },
    {
      "value": "downloaded",
      "label": "Đã tải"
    }
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Theo radio group: Tab một stop, arrows đổi lựa chọn, Space chọn. Nếu là panel switch thật thì dùng Tabs và pattern Tabs.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Khi không vừa chuyển Radio group/Select; không thu chữ/target. Giữ label group nhìn được.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Chỉ một selected.
- Label voice control đúng.
- External value đồng bộ.
- Theme giữ lựa chọn.
- Không pretend tabpanel khi chỉ filter.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[radio-group](./radio-group.md) · [tabs](./tabs.md) · [select](./select.md)

Tham khảo pattern: [APG Segmented control](https://www.w3.org/WAI/ARIA/apg/patterns/radio/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
