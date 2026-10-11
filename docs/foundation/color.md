# Màu sắc

Trạng thái: adapted/new. Nguồn số đo: [token JSON](../tokens/design-tokens.json), phần `color`; [bằng chứng](../research/sources.md).

## Hệ thống

Nền trung tính và CTA đen/trắng ấm giữ chất editorial của bản đầu. Tím iris dịu là accent cho link, focus, tiến độ và trạng thái chọn. Peach/lavender chỉ là màu phụ trong imagery, không nhuộm bề mặt ứng dụng.

Có 22 primitive màu tham chiếu (violet/neutral, 11 stop mỗi ramp) và 41 semantic token cho mỗi theme. Primitive phục vụ thiết kế; component dùng semantic token. Các màu trạng thái dùng vai trò độc lập, không gán nhầm màu brand cho thành công.

| Vai trò | Light | Dark |
| --- | --- | --- |
| `background` | #FFFFFF | #151515 |
| `surface` | #FFFFFF | #20201F |
| `surface-raised` | #FFFFFF | #282827 |
| `text-primary` | #1D1D1F | #F4F3EF |
| `text-secondary` | #646466 | #BABAB6 |
| `primary` / `on-primary` | #111211 / #FFFFFF | #F3F2ED / #1D1D1F |
| `link` | #705A96 | #C4B2DF |
| `selected-background` / `selected-foreground` | #F3EFF8 / #68528D | #2D2735 / #D3C5E5 |
| `border-subtle` | #E7E6E3 | #3E3E3B |
| `border-control` | #8B8A87 | #85857F |

## Dùng như thế nào

Nút chính dùng đủ bộ primary/default/hover/pressed với cùng `on-primary`. Link và icon tương tác dùng `link`. Từ hoặc chip đã chọn dùng cặp selected; trạng thái chọn phải có thêm nhãn, icon hoặc marker. Success/warning/error/info đều có foreground/background trong JSON.

Viền chia section dùng border-subtle; viền cần nhận biết ô nhập dùng border-control. Bề mặt nổi có border và geometry shadow, không chỉ đổi một màu nền. Overlay/shadow là hex tám chữ số có alpha, phải composite trước khi đo tương phản của nội dung đặt lên.

## Không dùng khi nào

- Không đặt chữ trắng lên primary sáng của dark mode.
- Không dùng `lavender-decoration` hoặc primitive nhạt cho body/link.
- Không dùng border-subtle làm dấu hiệu duy nhất nhận biết một input.
- Không dùng disabled-foreground cho metadata đang hoạt động.
- Không dùng chỉ màu để báo lỗi, tiến độ hoàn thành hoặc level CEFR.

## Kiểm tra

`tools/validate.py` đo cặp chữ–nền ở 4.5:1 và các cặp control/focus cần thiết ở 3:1. Ngoại lệ disabled, trang trí và alpha được ghi riêng, không tính là cặp đạt. Phải đo lại khi đặt semantic token lên bề mặt ngoài cặp dự kiến, ảnh nền hoặc gradient. Xem [WCAG contrast](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) và [non-text contrast](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html).
