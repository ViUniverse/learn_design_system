# Imagery và minh họa

Trạng thái: adapted/new. Bảng màu đào/lavender hỗ trợ nội dung nghe; không dùng làm trạng thái nghiệp vụ.

## Quy tắc

Cover lesson tỷ lệ 1:1, thumbnail compact 56–72px; hero/media frame 16:9 khi nội dung phù hợp. Màu đào dùng cặp peach-background/foreground. Ảnh có vùng thở, tránh text nằm trong bitmap. Giữ aspect ratio và kích thước dự kiến trước khi tải để không gây layout shift.

## Dùng như thế nào

Một bài nghe có cover liên quan chủ đề; nếu thiếu ảnh dùng pattern hình học hoặc icon topic rõ. Thông tin title, level, duration, downloaded vẫn là text bên ngoài ảnh. Ảnh chứa thông tin cần đọc phải có alternative text. Nếu cover lặp title đã nằm ngay cạnh, dùng alt rỗng để tránh đọc lặp.

User avatar khác lesson cover: avatar có fallback initials, cover có fallback chủ đề. Ảnh lỗi không xóa nội dung lesson card. Dùng crop/focal point phù hợp, không đổi layout giữa loading/success/error. Chỉ dùng artwork có quyền sử dụng rõ và lưu tác giả/nguồn cùng asset.

## Không dùng khi nào

Không copy ảnh sản phẩm, logo hoặc ảnh demo của OneNotch vào Vi Learn. Không gắn ảnh decorative với alt dài mô tả mọi màu. Không giả waveform ngẫu nhiên là dạng sóng thật. Không dùng backdrop ảnh cho text nếu không có giải pháp tương phản đã kiểm tra trên mọi crop.

## Kiểm tra

Offline và lỗi asset vẫn đọc được title/action; object-fit không cắt chủ thể quan trọng; dark mode không áp invert filter lên ảnh. Test người dùng tắt ảnh, data saver và reduced motion cho ảnh/video động. Web ưu tiên responsive assets, lazy-load ảnh dưới fold nhưng không lazy-load hero gây chậm nội dung chính.
