# Nguồn, bằng chứng và quyết định

Ngày rà soát: 08/10/2026. `observed` là thông số từ nguồn; `adapted` là điều chỉnh Vi Learn; `new` là bổ sung cho phạm vi ứng dụng.

## OneNotch — observed

[Landing tiếng Việt](https://www.tryonenotch.com/vi) đã được kiểm tra qua CSS công khai, computed styles và tương tác tại 375, 420, 900, 1440px. Snapshot token gốc được lưu cùng bộ này tại [onenotch-extraction.json](onenotch-extraction.json), gồm URL CSS và SHA-256 của bằng chứng.

Quan sát chính: SN Pro, Pecita cho nét viết tay; hero 40/56/72/80px; feature title 26px desktop, 22px mobile; CTA hero khoảng 56px, pill; card 20–32px; container feature 1120px, FAQ 1024px; section top padding 84/110/140px; hover 150–250ms. Tab đổi `aria-selected`, FAQ đóng item cũ khi mở item khác.

Nguồn này không chứng minh hệ dark mode, semantic status palette, form validation hoặc component của ứng dụng macOS. Một số video không phát được trong lần quan sát. Các phần đó của Vi Learn là thiết kế mới, không gán cho OneNotch.

## Điều chỉnh đã chốt — adapted

- Vòng 1.0 dùng Violet thay accent xanh. Sau phản hồi người dùng, vòng 1.1 khôi phục CTA trung tính, accent xanh, nền charcoal ở dark mode; vẫn giữ 41 semantic role mỗi theme.
- Giữ nhịp typography, khoảng trắng, pill và card bo mềm; chuẩn hóa spacing cho ứng dụng thay vì giữ mọi số lẻ của CSS landing.
- Target cảm ứng 44px, body tối thiểu 16px cho ứng dụng, typography nhỏ của navbar gốc không áp nguyên xi.
- Motion app ngắn hơn reveal 900ms của landing; bỏ scroll stage nhiều viewport-height và glass lens phức tạp.
- Pecita chỉ là font trang trí tùy chọn; hệ thống không đóng gói file font từ site tham chiếu.

## Khả năng tiếp cận — new

| Nguồn chính thức | Phạm vi sử dụng |
| --- | --- |
| [WCAG 2.2 Contrast](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) | Chữ thông thường 4.5:1; chữ lớn 3:1; Vi Learn kiểm tra body ở 4.5:1 |
| [Non-text contrast](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html) | Bộ phận cần nhận biết của control, trạng thái và focus |
| [Target size minimum](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html) | AA đặt mức tối thiểu 24px với ngoại lệ; Vi Learn chọn 44px làm mặc định |
| [Reflow](https://www.w3.org/WAI/WCAG22/Understanding/reflow.html) | Bố cục hẹp, zoom; ngoại lệ cho nội dung hai chiều cần thiết |
| [Focus not obscured](https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html) | Thành phần sticky không che focus |
| [Animation from interactions](https://www.w3.org/WAI/WCAG22/Understanding/animation-from-interactions.html) | Giảm chuyển động; đây là tiêu chí AAA, được chọn thêm cho Vi Learn |
| [WAI forms](https://www.w3.org/WAI/tutorials/forms/) | Label, grouping, hướng dẫn và báo lỗi |
| [WAI media](https://www.w3.org/WAI/media/av/) | Transcript, điều khiển player, phương án tiếp cận nội dung âm thanh |
| [APG catalog](https://www.w3.org/WAI/ARIA/apg/patterns/) | Phân loại component và chọn semantic pattern |
| [APG Dialog](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) | Focus trong modal, nền inert, đóng và trả focus |
| [APG Combobox](https://www.w3.org/WAI/ARIA/apg/patterns/combobox/) | Input và popup lựa chọn, phân biệt giá trị đang gõ/đã chọn |
| [APG Tabs](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/) | Roving focus, selected tab và panel |
| [APG Slider](https://www.w3.org/WAI/ARIA/apg/patterns/slider/) | Giá trị, phím và nhãn cho range |

APG là hướng dẫn pattern, không phải chứng chỉ tuân thủ WCAG. Tài liệu yêu cầu ưu tiên HTML native trước khi thêm ARIA. Các quy tắc đặc thù học/nghe trong component được thiết kế riêng cho Vi Learn.

## Typography và tài sản

[SN Pro repository](https://github.com/supernotes/sn-pro) xác nhận font family và các trọng lượng; [OFL](https://github.com/supernotes/sn-pro/blob/main/OFL.txt) là nguồn license. Tài liệu upstream khuyên dùng file regular/italic riêng trên web thay vì combined variable khi cần italic. Package Flutter đóng gói SN Pro kèm OFL; bản web được chuyển từ cùng TTF.

Pecita được xác nhận qua CSS của OneNotch là font viết tay đang dùng; file trên site là bản Latin. Bản public không dùng binary đó: showcase dùng font 5.4 từ [upstream](https://github.com/googlefonts/pecita), chuyển sang WOFF2 và kèm OFL. Văn bản có nghĩa mặc định dùng SN Pro/system; Pecita chỉ là accent trang trí. Xem [third-party notices](../../THIRD_PARTY_NOTICES.md).

Skill UI/UX Pro Max được dùng như nguồn gợi ý nội bộ cho accessibility và responsive. Đề xuất tự động về màu hồng, font Lora/Raleway và hành trình cuộn ngang không phù hợp quyết định đã chốt nên không đưa vào bộ này.

- Vòng 1.2: theo yêu cầu người dùng, đổi accent xanh sang tím iris dịu; giữ CTA trung tính, nền trắng/charcoal, typography và imagery giấy ấm.
