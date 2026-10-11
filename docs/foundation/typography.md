# Typography

Trạng thái: observed/adapted/new. OneNotch dùng SN Pro và Pecita; role ứng dụng là bổ sung. Nguồn số: `font`, `typography` trong [JSON](../tokens/design-tokens.json).

## Scale

| Role | Size / line-height / weight | Mục đích |
| --- | --- | --- |
| display | 40/1.1/600 → 56 → 72 → 80 | Hero marketing tại các mốc 735/1069/1441px |
| section | 32/1.12/600 → 40 → 56 | Tiêu đề section landing |
| h1 | 32/1.2/600 | Tiêu đề màn hình ứng dụng |
| h2 | 24/1.25/600 | Nhóm nội dung |
| h3 | 20/1.3/600 | Tiêu đề phụ |
| card-title | 22/1.2/600, desktop 26 | Feature card lớn, không phải list item |
| body | 16/1.5/400 | Nội dung ứng dụng |
| body-large | 18/1.6/400 | Lede, nội dung nổi bật |
| transcript | 18/1.7/400 | Đọc và chọn từ |
| small | 14/1.5/400 | Metadata đủ đọc |
| caption | 12/1.5/400 | Chú thích phụ ngắn |
| label | 14/1.4/500 | Form label, control |
| handwriting | 23/1.2/400, desktop 26 | Nét chú thích trang trí tùy chọn |

## Dùng như thế nào

Sans stack là SN Pro rồi system; mono dành cho code và số cần canh cột. Không force tabular numerals lên mọi chữ. Tracking âm nhẹ chỉ ở heading. Giữ semantic heading theo cấu trúc h1–h3 thay vì chọn tag theo kích cỡ. Bề ngang đoạn văn khoảng 65ch; transcript có max-width 760px.

Font size thiết kế dùng CSS px để tham chiếu, nhưng triển khai ưu tiên rem và text scaling. Đổi theme không đổi trọng lượng/chất lượng chữ. Form input 16px để tránh zoom bất ngờ trên mobile. Có thể dùng 14px metadata, nhưng không dùng caption 12px cho một đoạn hướng dẫn dài.

## Font asset

Không đóng gói font từ website tham chiếu trong bộ này. Dùng bản SN Pro upstream có OFL đi kèm, regular/italic riêng khi cần italic. [Upstream](https://github.com/supernotes/sn-pro) là nguồn phát hành; fallback phải làm trang sử dụng được ngay. Pecita là optional decorative accent; kiểm tra dấu Việt, không giả lập chữ nghiêng hoặc để một từ có dấu trộn nhiều font khác nhau.

## Không dùng khi nào

Không dùng viết tay cho transcript, nút, giá hoặc thông báo lỗi. Không ép xuống 10–11px để thẻ đủ chiều cao. Không clamp heading một dòng khi còn chỗ xuống dòng. Không dùng font-weight 800 theo price marketing cho h1 ứng dụng.

## Kiểm tra

Đọc chuỗi “Tiếng Việt: ă â ê ô ơ ư đ; Nguyễn, luyện nghe, chậm lại”; kiểm tra dấu kết hợp và nội dung tiếng Anh. Test 200% text scaling, zoom/reflow và font chưa tải. Nút và card phải nở theo nội dung, không cắt chữ.
