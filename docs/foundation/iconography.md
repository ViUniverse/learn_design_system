# Iconography

Trạng thái: new. Glyph dùng một bộ line icon nhất quán; ví dụ tên Lucide dưới đây là mapping thiết kế, không yêu cầu dependency trong domain.

## Quy tắc

ViewBox chuẩn 24×24, stroke tương đương 1.75–2px, nét bo mềm. Glyph 16/20/24/32px theo `size.icon-*`; action target vẫn 44px. Màu icon thông thường là text-secondary; active tương tác là link; icon trên CTA là on-primary. Semantic status dùng đúng foreground của trạng thái.

| Ý nghĩa | Glyph gợi ý | Nhãn người dùng |
| --- | --- | --- |
| Nghe | headphones / play | Nghe bài / Phát |
| Dừng tạm | pause | Tạm dừng |
| Lưu | bookmark / bookmark-check | Lưu bài / Đã lưu |
| Tua lại | rotate-ccw kèm số 10 | Tua lại 10 giây |
| Tải | download | Tải để nghe ngoại tuyến |
| Tốc độ | gauge | Tốc độ phát |
| Bản chép lời | text | Bản chép lời |
| Đóng | x | Đóng [tên vùng] |
| Lỗi | circle-alert | Nội dung lỗi đi cùng |

## Dùng như thế nào

Icon trang trí cạnh text có `aria-hidden=true`; icon-only button có accessible name và tooltip bổ sung. Khi action đổi, đổi cả glyph lẫn name. Số 10 của nút seek phải nhìn được, nhưng accessible name không đọc thành “rotate arrow”. Mỗi màn hình giữ một phong cách filled/line; filled có thể dành riêng selected khi được quy định.

## Không dùng khi nào

Không dùng emoji làm icon control. Không dùng color hoặc glyph lạ là cách duy nhất giải thích action. Không tự vẽ logo Vi Learn từ icon thương hiệu khác. Không gắn tooltip cho icon trang trí rồi khiến nó thành target bàn phím dư.

## Kiểm tra

Icon đọc được ở 16px và 200% scaling, không méo khi stroke scale; nhãn nói được bằng voice control. RTL không lật các symbol play/âm thanh; chỉ lật glyph hướng navigation khi ý nghĩa phù hợp. Bộ glyph bản sản xuất phải có license và phiên bản rõ trong manifest tài sản.
