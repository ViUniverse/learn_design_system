# Layout và responsive

Trạng thái: adapted/new. Nguồn: `layout`, `breakpoint` trong [JSON](../tokens/design-tokens.json).

## Khung ứng dụng

| Độ rộng | Gutter | Grid | Navigation |
| --- | --- | --- | --- |
| 320–599px | 16px | 4 cột; content thường 1 cột | Navbar + drawer; bottom nav nếu 3–5 destination |
| 600–899px | 24px | 8 cột; card có thể 2 cột | Compact nav; ưu tiên drawer nếu thiếu chỗ |
| từ 900px | 32px | 12 cột | Sidebar 256px khi cần navigation ứng dụng |
| từ 1200px | 32px | 12 cột trong container | Không kéo dài reading column |

Container content 1120px, wide 1280px, reading 760px, form 480px. Các con số là max-width, không là width tối thiểu. Các mốc marketing 735/1069/1441 chỉ đổi hero/type, tương ứng gần nhịp quan sát OneNotch. Không đồng nhất chúng với mốc app.

## Dùng như thế nào

Landing stack theo thứ tự đọc; lesson desktop có player và transcript, mobile giữ player trước transcript. Sidebar không chiếm chiều ngang trên mobile. Dùng container query nếu component nằm trong cột hẹp dù viewport rộng. Những thay đổi dựa trên độ rộng nội dung, không đo loại thiết bị.

Sticky navbar cao 64px mobile/72px desktop; mini player tối thiểu 72px cộng safe-area. Padding đáy và scroll-padding phải tính chiều cao thật, kể cả text wrap. Không che lỗi form hoặc focus phía dưới sticky chrome. Dùng `env(safe-area-inset-*)` ở mép thiết bị.

## Không dùng khi nào

Không dùng fixed-width card, absolute position cho label dài hoặc 100vh như điều kiện cần đọc nội dung. Không bắt người dùng scroll ngang cả trang; ngoại lệ table/seek visualization hai chiều chỉ trong vùng có nhãn. Không đổi thứ tự DOM chỉ để tạo bố cục desktop đẹp.

## Kiểm tra

320/375/768/1024/1440px, landscape, 200% text scaling và zoom 400% với viewport tương đương 320 CSS px. Tiêu chí [reflow](https://www.w3.org/WAI/WCAG22/Understanding/reflow.html) và [focus không bị che](https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html) là baseline; kiểm tra cả khi virtual keyboard mở.
