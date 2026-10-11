# Nguyên tắc thiết kế

Trạng thái: adapted/new. Tham chiếu [MASTER](../MASTER.md) và [nguồn](../research/sources.md).

## Mục tiêu

Vi Learn giúp người học dành một khoảng nghe có chất lượng. Giao diện ưu tiên bài nghe, ngữ cảnh câu và hành động học tiếp; ít trang trí hơn landing tham chiếu khi chuyển sang ứng dụng.

## Quy tắc

1. **Một hành động chính trong một vùng quyết định.** Trong lesson player, Play là chính; lưu bài là thứ cấp. Khi hoàn thành bài, hành động chính có thể đổi sang ôn từ, nhưng không đổi vị trí bất ngờ khi đang bấm.
2. **Nội dung dẫn dắt.** Tiêu đề có độ tương phản cao, mô tả ngắn, metadata thứ cấp. Không dùng typography display cho mọi thẻ.
3. **Hệ thống xác nhận sự thật.** Loading, buffering, offline, error, saved là các trạng thái khác nhau. Dữ liệu chưa tải không được thể hiện thành 0 bài học hoặc 0 phút đã nghe.
4. **Phương thức tương tác ngang quyền.** Hover là phản hồi bổ sung; chức năng có đường dùng bằng click/tap, bàn phím, assistive technology.
5. **Ưu tiên tiếp tục công việc.** Tra từ mở popover; tác vụ dài mở màn hình. Modal chỉ khi cần tạm chặn nền để quyết định rõ ràng.
6. **Cho người học quyền điều khiển.** Tốc độ, transcript, dịch và tải ngoại tuyến là lựa chọn rõ. Không autoplay hoặc tự ép chạy theo đoạn hiện tại.

## Dùng như thế nào

Bắt đầu từ nhiệm vụ của người dùng; chọn component qua [ma trận](../component-selection.md), rồi ghép pattern. Thay token thương hiệu ở tầng theme, không thay các quy tắc bàn phím cho từng màn hình. Cấu hình mặc định nên hỗ trợ người mới mà không ẩn quyền lựa chọn của người dùng có kinh nghiệm.

## Không dùng khi nào

Không áp dụng tính tối giản để xóa label, trợ giúp hoặc thông báo lỗi. Không dùng gam tím làm mã thành công/thất bại. Không tái tạo notch/lens của OneNotch như nhận diện Vi Learn: đó là hình ảnh sản phẩm của nguồn tham chiếu.

## Tiêu chí kiểm tra

- Người mới phân biệt được nghe, lưu và tiếp tục mà không đọc hướng dẫn.
- Bản hẹp vẫn có thông tin về level, thời lượng và trạng thái tải.
- Mỗi trạng thái bất thường có nguyên nhân hoặc bước tiếp theo phù hợp.
- Không component nào chứa network/storage hoặc quy tắc học tập của domain.
