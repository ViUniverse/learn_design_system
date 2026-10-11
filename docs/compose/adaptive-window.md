# Compose · Adaptive window

Vi Learn bố trí theo **vùng thực sự có thể dùng**, gồm kích thước Flutter view,
safe area, vùng camera/bản lề/vùng chia đang hoạt động và cỡ chữ. Không chọn bố
cục bằng tên máy, một góc gập cố định hay suy luận rằng mọi màn hình rộng đều
là máy gập.

## Phân chia trách nhiệm

`foldable_info` chỉ lấy số đo native và trạng thái có/không có dữ liệu. Package
thiết kế chuyển số đo thành policy bố trí. App sở hữu route, lựa chọn destination,
phiên nghe và dữ liệu mẫu. Domain không import Flutter hay plugin này.

`LearnWindow` bao quanh toàn bộ app surface trước các SafeArea của từng pane.
Nó dùng handle của đúng Flutter view và chia sẻ một subscription layout. Nó
không nghe stream góc gập, vì góc thay đổi liên tục không phải lý do để tính lại
mọi widget. Hủy surface sẽ hủy subscription của surface, không hủy service chung.

## Dữ liệu và tọa độ

`FoldableSpace.toBox` chuyển vùng native sang app surface. Chỉ snapshot có
view size, pixel ratio, session và revision phù hợp mới được dùng. Khi xoay,
resize hoặc dữ liệu bridge chưa sẵn sàng, dùng insets/display features Flutter
đang có và chờ snapshot mới. Không giữ camera/bản lề ở tọa độ màn hình cũ.

Vùng native `isActive=false` được loại khỏi policy. `unknown` khác với false;
vùng cản chưa rõ loại nhưng có frame được tránh theo hướng thận trọng. Margin
của iOS đã nằm trong frame; không cộng lần thứ hai. `navigationSide` là gợi ý
về cạnh, không phải bằng chứng có toolbar UIKit hoặc màn hình vật lý nào đang bật.

Đặt scope ở toàn bộ app surface; không bọc scope trong Transform. Consumer cần
tọa độ của widget đã biến đổi phải dùng `FoldableSpace` trực tiếp. Pane áp
`mediaQueryForPane` để chỉ nhận phần safe area/keyboard ở cạnh mà nó chạm vào.

## Thanh công cụ và điều hướng

`LearnToolbar` nhận icon actions và menu triggers do app cung cấp. Mỗi target
48 logical px; trừ vùng cản khỏi từng hàng và xếp tiếp sang hàng khi hết chỗ.
Không bỏ action và không tạo overflow mà thiếu nút mở. Title chỉ hiện khi đủ
chỗ, không thu chữ hoặc ép target nhỏ lại. Bar cần chiều rộng tối thiểu một
target; app chọn pane phù hợp trước khi đặt bar.

`LearnNavigationBar` giữ label, semantics và target khi chữ lớn bằng cách xuống
hàng. `LearnNavigationRail` cho phép cuộn các destination khi chiều cao nhỏ.
`LearnPaneLayout` kiểm tra kích thước pane và cỡ chữ trước khi chọn split; dùng
hysteresis quanh ngưỡng để tránh đổi chế độ liên tục. Cạnh start/end native
được giải theo Directionality; bản lề lệch tâm giữ đúng frame thật.
Rail phải vừa trong pane chứa nó, sau khi trừ safe area. Nếu rail làm pane
quá hẹp, chuyển xuống bottom navigation trước khi bỏ chế độ hai pane.

`LearnNavigationLayout` phân biệt rail trong nội dung với dải điều khiển native.
Khi iOS cung cấp cạnh dọc và safe area có dải đủ rộng, `edgeFrame` nằm ngay
trong dải đó, dưới camera/status và trên keyboard/home indicator. Trừ các vùng
cản theo chiều dọc, chọn đoạn dưới cùng còn đủ một target; destination cuộn
nếu đoạn ngắn. Không trừ thêm một cột rail khỏi nội dung. Cạnh start/end theo
Directionality hỗ trợ cả cạnh trái. Hint không có dải đủ chỗ thì dùng navigation
ngang. Thanh dọc dùng icon, vẫn giữ tooltip và tên cho accessibility.

Không có hint native: rail khi vùng dùng được rộng ít nhất 600 và cao ít nhất
480 logical px, chữ không quá 1.5×. Compact height, chữ lớn và fold ngang
half-open (tabletop) dùng navigation ngang trong pane. Đây là policy của Vi
Learn; không suy luận rằng Android có cạnh dọc kiểu Duo.

Nếp gập không có diện tích không che pixel. Home dùng toàn bộ surface khi player
đang thu gọn; chỉ chia browse/player sang hai vùng khi player mở. Bản lề/vùng
chia có diện tích vẫn giới hạn pane để không cắt mất nội dung qua vật cản.

`LearnWindow` luôn tô nền opaque **trước** clip nội dung. Camera/status margin
không phải lỗ vật lý; để chúng transparent làm lộ mặt nền đen native. Chỉ nội
dung và hit testing tránh vật cản, nền app vẫn phủ tới cạnh. System bars
transparent, icon đổi sáng/tối theo nền. App bật edge-to-edge lúc khởi tạo.

## State và giới hạn

Thay đổi geometry/theme không tạo controller phiên nghe mới. Animation thuộc
compose/presentation; state nghiệp vụ không nằm trong package. Reduced motion
được tôn trọng. Vùng bị che được loại khỏi paint nội dung và hit testing.

Bridge không tự biết overlay do app vẽ. Camera native không chứng minh rằng
mọi UIKit toolbar/gesture/bo góc đã được đo đầy đủ. Flutter insets chỉ mô tả
keyboard ở cạnh; keyboard nổi/chia đôi cần frame riêng nếu OS/plugin cung cấp.
Giới hạn này không được biến thành dữ liệu giả hoặc trạng thái thành công giả.

## Nghiệm thu

- Native stream và fallback; snapshot cũ sau xoay/resize; inactive region.
- Mở phẳng, mở một phần, đóng và xoay trên iOS/Android gập; máy thường.
- Toolbar target không đè camera/bản lề, mọi action còn mở được.
- Navbar/rail, chữ lớn, keyboard, dark/light, đọc và đóng dictionary.
- Phiên nghe, vị trí, lựa chọn và scroll không reset khi layout đổi.

API hiện tại được liệt kê trong [README package](../../README.md). Spec về
[navbar](../component/navbar.md), [toolbar](../component/toolbar.md) và
[responsive layout](../foundation/layout-responsive.md) quy định phần trải nghiệm.

## Nguồn policy

- [Apple: Designing for iPhone Duo](https://developer.apple.com/design/human-interface-guidelines/designing-for-iphone-duo) — vị trí controls theo display/tư thế, dưới vùng status.
- [Apple: Raise the bar with iPhone Duo](https://developer.apple.com/videos/play/tech-talks/111462/) — native container, gợi ý cạnh dọc, icon và overflow.
- [Android: Build adaptive navigation](https://developer.android.com/develop/adaptive-apps/guides/build-adaptive-navigation) — compact height và tabletop ưu tiên bottom navigation.
- [Android: System bars](https://developer.android.com/design/ui/mobile/guides/foundations/system-bars) — nền system bars và tương phản icon.
