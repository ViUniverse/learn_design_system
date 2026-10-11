# Learn Design System

Phiên bản đặc tả 1.3.0 · 11/10/2026 · tiếng Việt.

## Phạm vi

Bộ đặc tả độc lập cho website marketing và ứng dụng nghe học Vi Learn: foundation, token light/dark, component và mẫu ghép màn hình. Mỗi component có hợp đồng thiết kế trung lập với framework; tên thuộc tính minh họa không phải API Flutter đã triển khai. Implementation Flutter trong `packages/learn_design_system/lib` được chia foundation/component/compose; app `apps/vilearn` sở hữu mock data và nghiệp vụ. Catalog đặc tả có phạm vi rộng hơn số widget hiện có. Backend không thuộc package thiết kế.

“Đủ” trong phiên bản này nghĩa là có thể đặc tả trọn các luồng landing → khám phá → nghe/bản chép lời → lưu từ → ôn tập → cài đặt, đồng thời có các control phổ thông cho form, navigation, overlay, bảng dữ liệu và feedback. Catalog là danh sách phạm vi cố định, không phải tuyên bố chứa mọi component có thể tồn tại.

## Thứ tự nguồn sự thật

1. Yêu cầu người dùng và ranh giới kiến trúc của workspace.
2. `tokens/design-tokens.json`: số đo và màu Vi Learn; `tokens/design-tokens.css` là đầu ra sinh từ JSON.
3. Tài liệu foundation và từng component; quyết định dùng component nằm trong `component-selection.md`.
4. Mẫu ghép trong `compose/`.
5. Bằng chứng OneNotch trong `research/`: chỉ phần quan sát được, không ghi đè thiết kế Vi Learn.

## Nguyên tắc bắt buộc

- Bình tĩnh, dễ đọc, tập trung vào nghe. Nền trắng hoặc charcoal trung tính; tím iris dịu dùng tiết chế cho link, focus, selected state, tiến độ/waveform và icon thương hiệu. Peach/lavender tiết chế trong imagery.
- Light: CTA đen với chữ trắng. Dark: CTA trắng ấm với chữ charcoal. Không nhuộm tím các bề mặt hoặc dùng màu accent cho toàn bộ CTA.
- Dùng tên màu theo vai trò, không đặt hex trực tiếp trong component.
- Nội dung tiếng Việt phải giữ dấu đầy đủ, không viết tay cho thông tin cần đọc chính xác.
- Khung card bo tròn mềm; nút chính hình pill. Typography lớn dành riêng marketing, không áp vào mọi màn hình ứng dụng.
- Body ứng dụng 16px, line-height 1.5; transcript 18px/1.7. Không cố định chiều cao vùng chữ.
- Hit target Vi Learn ít nhất 44×44 CSS px / logical px, dù glyph nhỏ hơn. Đây là lựa chọn sản phẩm cao hơn mức WCAG AA tối thiểu trong các trường hợp thông thường.
- Focus 2px, offset 3px; không bị navbar, drawer hoặc mini player che. Mọi hành động thiết yếu dùng được bằng bàn phím và cảm ứng.
- Không tự phát âm thanh. Timeline không cướp focus hoặc tự cuộn khi người dùng đang đọc đoạn khác.
- Không mô phỏng trạng thái đã lưu, tải xong, học xong hoặc đồng bộ thành công khi chưa có bằng chứng từ ứng dụng.
- Component nhận dữ liệu/callback; app giữ route, storage, network, validation nghiệp vụ và chính sách dữ liệu.

## Chọn đúng mức giao diện

| Ý định | Ưu tiên |
| --- | --- |
| Thực thi hành động | Button / Icon button |
| Đi sang tài nguyên hoặc route | Text link |
| Chọn một giá trị | Radio group, Select, Segmented control |
| Đổi panel nội dung | Tabs |
| Đổi cài đặt nhị phân có hiệu lực ngay | Switch |
| Thông báo cần sửa tại chỗ | Form field / Alert / Error state |
| Thông báo ngắn sau hành động | Toast có bản ghi trạng thái bền vững ở nội dung liên quan |
| Tác vụ cần tập trung và chặn nền | Dialog |
| Tra nghĩa mà vẫn đọc được transcript | Dictionary popover |
| Điều khiển timeline âm thanh | Seek bar; Waveform chỉ là lớp hình ảnh |

## Tích hợp

Web dùng CSS variables `--vl-*`, chọn `data-theme="light"` hoặc `data-theme="dark"` trên `<html>`; bỏ thuộc tính để theo hệ thống. Flutter ánh xạ JSON sang theme extension trong tầng presentation của app/brand adapter. Không tạo dependency từ domain sang theme và không import `lib/src` của package khác. Xem [Token & theming](foundation/tokens-theming.md).

## Kiểm tra và trạng thái

Đặc tả được kiểm tra cấu trúc, link nội bộ, token reference, coverage catalog và các cặp tương phản màu bằng `python3 tools/validate.py`; sinh lại CSS bằng `python3 tools/build_tokens.py`. `verification/report.json` ghi chính xác phạm vi đã kiểm tra. Checklist của từng component là yêu cầu kiểm thử khi triển khai, không phải tuyên bố widget đã qua kiểm thử screen reader.

Nguồn và khác biệt được ghi trong [research/sources.md](research/sources.md). Các nguồn WAI được tổng hợp thành yêu cầu của Vi Learn, không sao chép nguyên bài hướng dẫn.
