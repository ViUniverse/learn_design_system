# Ma trận chọn component

Đọc ý định trước, chọn component sau. Nếu một tác vụ không thể đáp ứng hợp đồng của component hiện có, bổ sung contract và provenance thay vì đổi semantics âm thầm.

| Nhu cầu | Dùng | Không dùng | Lý do |
| --- | --- | --- | --- |
| Thực thi hành động | [Button](component/button.md) | Link href rỗng | Action và navigation có keyboard/browser behavior khác nhau |
| Đi route | [Text link](component/text-link.md) | Button gọi router cho mọi đích | Link hỗ trợ mở tab/copy address |
| Action quen, chỗ hẹp | [Icon button](component/icon-button.md) | Glyph clickable không label | Vẫn cần accessible name và target44 |
| Nhập một dòng | [Text input](component/text-input.md) | Textarea1 dòng | Native input/type/autocomplete đúng |
| Nhập dài | [Textarea](component/textarea.md) | Text input cao giả multiline | Enter tạo newline đúng |
| Tập nhỏ, một lựa chọn | [Radio](component/radio-group.md) | Checkbox | Selection duy nhất |
| Tập lớn, một lựa chọn | [Select](component/select.md) | Menu action | Field value có label và selected value |
| Tìm trong tập lớn | [Combobox](component/combobox.md) | Input + popup không semantics | Query/active option/committed value khác nhau |
| Nhiều lựa chọn độc lập | [Checkbox](component/checkbox.md) | Radio | Không loại lựa chọn trước |
| Cài đặt bật/tắt ngay | [Switch](component/switch.md) | Checkbox submit mơ hồ | Ý định hiệu lực ngay |
| Chọn enum ngắn | [Segmented control](component/segmented-control.md) | Tabs | Không panel associated |
| Đổi panel | [Tabs](component/tabs.md) | Segmented radio giả tab | Semantics tab/panel và keyboard riêng |
| Điều chỉnh số | [Slider](component/slider.md) | Progress | Người dùng thay đổi value |
| Tiến độ tác vụ | [Progress](component/progress.md) | Slider | Value chỉ read-only |
| Timeline playback | [Seek bar](component/seek-bar.md) | Waveform clickable-only | Có value time và keyboard seek |
| Hình biên độ | [Waveform](component/waveform.md) | Progress fake âm thanh | Data samples thực, decorative layer |
| Group nội dung | [Card](component/card.md) | Dialog | Không chặn background |
| Nội dung phụ collapsed | [Accordion](component/accordion.md) | Tabs nhiều tầng | Disclosure rõ với heading |
| Thông tin rất ngắn | [Tooltip](component/tooltip.md) | Popover cho mọi hint | Không cần actions/Tab |
| Thông tin/controls ngắn | [Popover](component/popover.md) | Tooltip interactive | Có thể tương tác; nền vẫn dùng được |
| Tra nghĩa trong bài | [Dictionary popover](component/dictionary-popover.md) | Tooltip | Ngữ cảnh, save và privacy/data scope |
| Tác vụ chặn nền | [Dialog](component/dialog.md) | Popover aria-modal giả | Focus trap và inert thật |
| Panel mobile | [Drawer](component/drawer.md) | Sidebar fixed256 | Phù hợp viewport và safe-area |
| Thông báo tại chỗ | [Alert](component/alert.md) | Toast duy nhất | Còn đọc/sửa được |
| Thông báo toàn app | [Banner](component/banner.md) | Alert lặp từng card | Scope toàn app |
| Xác nhận ngắn | [Toast](component/toast.md) | Modal thành công | Không ngắt workflow |
| Chưa có nội dung | [Empty state](component/empty-state.md) | Error | Fetch thành công với tập rỗng |
| Fetch thất bại | [Error state](component/error-state.md) | Empty state | Cần recovery phù hợp |
| Hình khung đã biết đang tải | [Skeleton](component/skeleton.md) | Content giả | Giữ geometry, aria-busy |
| Pending chưa biết % | [Loading indicator](component/loading-indicator.md) | Progress phần trăm giả | Không có denominator |
| So sánh theo cột | [Data table](component/data-table.md) | Grid cards | Header/cell association |
| Quét bài/từ | [List](component/list.md), [Lesson card](component/lesson-card.md) | Table quá nhiều cột mobile | Nội dung tốt hơn theo hàng/card |
| Rich prose | [Markdown](component/markdown.md) | Transcript sync | Không có timeline segment model |
| Đọc nội dung nghe | [Transcript](component/transcript.md) | Live region toàn bài | Text/language/context ổn định |
| Ôn một mục | [Review card](component/review-card.md) | Vocabulary card tự grade | Reveal/grade/session contract riêng |
| Trạng thái ngoại tuyến | [Download status](component/download-status.md) | Buffering state | Asset verification khác playback |

## Quy tắc composition

Label/field không lồng interactive action mâu thuẫn; Card không đồng thời là button và chứa button. Overlay có một owner focus stack. Media có một session owner. List/card tiếp tục đọc được khi tải ảnh thất bại. Theme adapter dùng semantic tokens cho cả native controls và custom controls.
