# Motion

Trạng thái: adapted/new. Nguồn OneNotch có hover 150–250ms, reveal 900ms; Vi Learn rút ngắn motion ứng dụng. Token: `motion` trong [JSON](../tokens/design-tokens.json).

## Thời gian và easing

Instant 0ms; fast 120ms cho hover/pressed; base 200ms cho phản hồi; slow 320ms cho drawer/accordion; reveal 500ms chỉ marketing. Standard `.2,0,0,1`; enter `.16,1,.3,1`; exit `.4,0,1,1`. Ví dụ CSS là `--vl-duration-base` và `--vl-ease-enter`; toàn bộ vai trò nằm trong JSON.

## Dùng như thế nào

Motion chỉ giải thích nguồn/đích hoặc trạng thái. Button đổi màu mà không dịch vị trí. Drawer chuyển nhỏ theo hướng mở; accordion đo chiều cao nội dung, tránh cắt text. Giá trị seek và timer cập nhật ngay, không nội suy làm chậm điều khiển. Loading giữ geometry và label ổn định.

Với `prefers-reduced-motion: reduce`, duration token về 0ms; bỏ shimmer, orbit, parallax, scale và auto-scroll. Loading vẫn có nhãn tĩnh hoặc progress thật. Người dùng bật giảm chuyển động trong app cần override tương đương dù OS chưa bật. Không tắt âm thanh chỉ vì giảm motion; đó là cài đặt khác.

## Không dùng khi nào

Không animate mọi card khi scroll trong màn hình học. Không loop trang trí hoặc waveform giả như bằng chứng có tiếng phát. Không dùng flash để báo lỗi. Không đợi animation hoàn tất mới ghi nhận click hoặc thay semantic state.

## Kiểm tra

Theme đổi không flash sai theme; focus không nhảy khi layout chuyển; không có animation thiết yếu để hiểu thông báo. Test reduced motion, CPU chậm và rapid input. Yêu cầu bổ sung theo [Animation from Interactions](https://www.w3.org/WAI/WCAG22/Understanding/animation-from-interactions.html), không gán tiêu chí AAA này thành AA.
