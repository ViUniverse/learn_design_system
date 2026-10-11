# Elevation và layer

Trạng thái: new/adapted. Nguồn: `shadow`, `layer`, màu `shadow/overlay` trong [JSON](../tokens/design-tokens.json).

## Elevation

none cho content; sm `0 2px 8px` cho vùng selected/nổi nhẹ; md `0 8px 24px` cho menu/popover; lg `0 24px 64px` cho modal. Màu bóng lấy `--vl-shadow`, không hard-code đen. Dark dùng surface-raised và border, không chỉ tăng bóng.

## Layer

Base 0; sticky 10; dropdown 20; overlay 30; modal 40; popover 50; tooltip 60; toast 70. Đây là thứ tự portal nền tảng. Khi một dialog mở menu, menu phải thuộc overlay stack của dialog và vẫn nằm trong focus boundary; không đưa dropdown của nền lên trên modal vì layer toàn cục.

## Dùng như thế nào

Tạo một overlay manager để sở hữu stacking, restore focus, scroll lock và dismissal theo layer đang trên cùng. Overlay dưới modal dùng màu alpha của theme. Popover không modal không làm nền inert. Modal thực sự chặn nền; toast không chặn thao tác và không tự giành focus.

Pointer events của vùng chỉ hiển thị như tooltip không cản control phía dưới. Header sticky không vượt dialog. Vùng toast chừa safe-area và mini player; thông báo quan trọng có chỗ đọc lại trong nội dung, không phụ thuộc toast nổi.

## Không dùng khi nào

Không tăng z-index vô hạn để sửa overlay. Không dùng shadow làm dấu hiệu duy nhất cho selected state. Không có nhiều modal lồng nhau theo mặc định; nếu xác nhận hủy dữ liệu, đóng/mở theo workflow rõ và giữ focus.

## Kiểm tra

Menu bên trong dialog dùng được bằng bàn phím; Esc đóng layer đúng; backdrop không che nội dung thông báo; khi đóng overlay focus về trigger còn tồn tại hoặc vị trí kế tiếp hợp lý. Mọi phần bị làm inert không còn focusable.
