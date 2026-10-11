# Dữ liệu và trực quan hóa

Trạng thái: new. Dùng cho tiến độ nghe/học, thống kê ngắn và bảng nội dung; không biến design system thành dashboard analytics.

## Quy tắc

Một chỉ số progress dùng progress-active/track với số hoặc nhãn đi cùng. Nhiều loại trạng thái phải có label, pattern hoặc icon; không lấy warning/error làm màu category bình thường. Dữ liệu học không có giá trị phải hiện “Chưa có dữ liệu”, không nội suy hoặc điền 0.

`stat` hiển thị value, unit, kỳ đo và nguồn/định nghĩa khi cần. Completion nghe bài không đồng nghĩa mastery từ vựng. Nếu hiển thị phần trăm, định nghĩa mẫu số và xử lý 0/unknown denominator. Progress indeterminate khác determinate; không dựng fake percentage để làm loading.

## Dùng như thế nào

Learning progress card tối đa vài metric có liên hệ, ví dụ 12/20 phút mục tiêu hôm nay và 3 bài đã nghe. Nếu có chart lịch sử, trục/đơn vị/khung thời gian đọc được, cung cấp table/text alternative. Tooltip chỉ bổ sung, không chứa thông tin duy nhất. Table semantic cho giá trị cần so sánh; pagination cho tập lớn.

Số tabular để canh cột; format theo locale. Danh sách lesson ưu tiên card/list, bảng dành quản trị hoặc dữ liệu cột thực sự. Sorting và filtering không đổi focus bất ngờ; thông báo số kết quả bằng polite live region nếu hợp lý.

## Không dùng khi nào

Không dùng donut cho tiến độ không có tổng xác định. Không nói “thành thạo” dựa trên số phút. Không dùng hình màu không nhãn cho streak/level. Không animate count từ 0 làm người dùng tưởng có dữ liệu mới. Không tạo metric giả để lấp card.

## Kiểm tra

Unknown/zero/max/over-target, số dài, dữ liệu stale, đổi timezone/ngày, offline. Chỉ số quan trọng có text alternative; tương phản marks và trạng thái không phụ thuộc màu. Người dùng xem data mà không có animation vẫn hiểu kết quả.
