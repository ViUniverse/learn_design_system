# Compose · Cài đặt

Mục tiêu: thay đổi chế độ hiển thị/nghe và dữ liệu với hiệu lực rõ, dễ khôi phục.

## Composition

[Sidebar](../component/sidebar.md)/[Navbar](../component/navbar.md) → nhóm h2 + [Card](../component/card.md) → [Radio group](../component/radio-group.md) hoặc [Segmented control](../component/segmented-control.md) theme System/Light/Dark → [Switch](../component/switch.md) dịch/follow/giảm motion → [Select](../component/select.md) ngôn ngữ/tốc độ → [Alert](../component/alert.md) lỗi persistence → [Dialog](../component/dialog.md) thao tác dữ liệu nguy hiểm.

Theme thuộc presentation preference; dùng [token theming](../foundation/tokens-theming.md), cập nhật native controls và overlays cùng lúc. Font/type/spacing không bị đổi khi theme chuyển. System là xóa override explicit, không đo sáng/tối một lần rồi lưu nhầm thành choice.

## Hành vi

Switch áp ngay; form nhiều field cần Lưu phải nói rõ. Async persistence có pending/error, rollback hoặc trạng thái chưa sync phải được mô tả. Data removal có scope chính xác (bản tải local, entry từ, toàn account) và confirmation/undo tương ứng; design system không thực thi delete/network.

## State coverage

Read-only scope, disabled có reason, unknown current preference trước load, pending-save và conflict do app cung cấp. Không gọi success chỉ vì visual toggle đổi.

## Không dùng

Không dùng CSS invert dark mode; không đặt cloud opt-in chung mơ hồ; không giấu lỗi lưu trong toast hết hạn; không dùng danger color cho mọi nút Hủy.

## Kiểm tra

System media preference change, explicit preference thắng OS, overlay/player state không reset, read-only/disabled, errors/retry, bilingual UI, local-only offline persistence và privacy boundaries.
