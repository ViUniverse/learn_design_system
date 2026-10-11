# Interaction và accessibility

Trạng thái: new. Mục tiêu thiết kế WCAG 2.2 AA; mỗi triển khai vẫn phải kiểm tra thực tế. [Nguồn](../research/sources.md) phân biệt tiêu chí chuẩn và lựa chọn bổ sung.

## Mặc định

- Chữ body ít nhất 4.5:1; thành phần control cần nhận biết 3:1 so với màu kề.
- Hit target 44×44px của Vi Learn, không nhầm với WCAG AA target minimum 24px có ngoại lệ.
- Focus 2px, offset 3px, màu focus-ring. Không thay focus bằng hover.
- Dùng HTML native, label rõ, order Tab theo DOM. Không dùng positive tabindex.
- Group composite dùng một tab stop và phím mũi tên theo pattern; không áp roving tabindex vào list link thông thường.
- Không xóa outline nếu không cung cấp ring tương đương. Scroll focus vào vùng không bị sticky chrome che.

## Trạng thái tương tác

Default → hover/focus → pressed → pending → success/error. Pending không đồng nghĩa disabled vĩnh viễn. Read-only vẫn đọc/copy được; disabled không nhận action. Selected không đồng nghĩa focused; cả hai phải đồng thời nhìn thấy khi cần.

Đổi dữ liệu nền không cướp focus. Thông báo kết quả dùng polite live region; lỗi khẩn cấp có thể assertive, không đọc lại timer hoặc toàn transcript mỗi giây. Hủy tác vụ cần có đường trở lại; Esc chỉ đóng overlay trên cùng, không hủy dữ liệu âm thầm.

## Dùng như thế nào

Checklist từng component bổ sung yêu cầu riêng. Modal focus scope thuộc overlay manager; route change đặt focus vào h1/main phù hợp. Có skip link đến main. Native range cung cấp keyboard cho seek/volume. Drag luôn có phương án click/phím thay thế.

## Không dùng khi nào

Không thêm role button vào div nếu có thể dùng button. Không dùng role menu cho site navigation. Không gắn `aria-live` vào vùng lớn đổi liên tục. Không báo “đã lưu” trước khi ứng dụng xác nhận. Không giả toàn bộ UI đã đạt chuẩn chỉ vì token contrast đạt.

## Kiểm tra

Keyboard-only, VoiceOver/Safari, NVDA/Firefox hoặc Chrome phù hợp nền tảng, touch screen reader, zoom/reflow, 200% text scaling, high contrast/forced colors, reduced motion. Audit name/role/value, các hướng thoát khỏi overlay và focus khi DOM bị xóa. [APG](https://www.w3.org/WAI/ARIA/apg/patterns/) là nguồn pattern để triển khai.
