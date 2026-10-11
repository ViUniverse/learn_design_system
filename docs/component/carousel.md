# Carousel

Nhóm: Surfaces · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Cho xem từng slide trong tập nội dung bổ sung có thứ tự; không thay catalog cần quét nhiều mục.

## Cấu tạo

Region label; slides; previous/next; position; optional pause khi tự chuyển.

## Thông số và token

Frame tỷ lệ ổn định, radius-feature; control44–56, gap8; indicator có số/text, không chỉ dot.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

manual mặc định; auto-rotation chỉ marketing có pause rõ và không chạy khi reduced motion.

## Trạng thái và chuyển trạng thái

Current slide; transitioning; paused; loading/error media. Focus không tự chuyển sang slide mới.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Product showcase landing.
- Nội dung featured ít slide.
- Walkthrough hình ảnh bổ sung.

## Không được dùng khi nào

- Không giấu thông tin cốt lõi ở slide cuối.
- Không autoplay âm thanh.
- Không dùng cho danh sách lesson dài.
- Không chỉ hỗ trợ swipe.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `slides` | `Slide[]` | bắt buộc |
| `index` | `number` | 0 |
| `autoRotate` | `boolean` | false |
| `onIndexChange` | `callback` | bắt buộc |
| `label` | `string` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "label": "Khám phá Vi Learn",
  "index": 0,
  "autoRotate": false,
  "slides": [
    "listen",
    "transcript",
    "words"
  ]
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Buttons native; Tab chỉ tới slide hiện và controls; hidden slides inert. Auto rotation dừng khi focus/hover, có pause button.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Một slide compact; swipe bổ sung buttons; caption wrap; không crop control khỏi frame.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Pause/reduced-motion.
- Hidden links không tabbable.
- Slide X/Y đọc được.
- Keyboard next/prev.
- Focus giữ vị trí hợp lý.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[image](./image.md) · [icon-button](./icon-button.md) · [card](./card.md)

Tham khảo pattern: [APG Carousel](https://www.w3.org/WAI/ARIA/apg/patterns/carousel/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
