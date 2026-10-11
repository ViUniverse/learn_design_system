# Compose · Ngoại tuyến và download

Mục tiêu: người dùng biết bài nào thật sự có thể nghe/đọc khi không có mạng và sửa được tác vụ tải lỗi.

## Composition

[Banner](../component/banner.md) scope network → [Lesson card](../component/lesson-card.md) với [Download status](../component/download-status.md) → queue [List](../component/list.md)/[Progress](../component/progress.md) → [Error state](../component/error-state.md) hoặc [Alert](../component/alert.md) retry. [Audio player](../component/audio-player.md) và [Transcript](../component/transcript.md) tiếp tục từ asset đã xác nhận.

## State machine

Not-downloaded → queued → downloading → verifying → available. Cancel/paused/failed là nhánh riêng; retry phục hồi theo capability thật. 100% bytes vẫn là verifying nếu chưa kiểm tra asset. Available yêu cầu audio và các assets bắt buộc của phiên bản lesson; partial cache không đủ.

Offline banner không làm mọi action disabled: local saved words/transcript còn dùng được. Tác vụ cloud cần mạng có explanation và retry. Remove offline copy không xóa saved vocabulary hoặc lịch sử nghe, trừ action/phạm vi khác được người dùng chọn rõ.

## Dữ liệu

App/controller giữ manifest assets, sizes/hash/version theo policy, filesystem/storage và authorization. UI không tự quyết integrity hoặc content ownership. Unknown total dùng indeterminate; queue giữ ID để cancel đúng bài. Disk full có bước giải phóng dung lượng.

## Không dùng

Không báo downloaded từ browser cache; không progress giả; không thất bại thành empty; không thông báo mạng chỉ bằng icon; không khởi động download hàng loạt mà thiếu chọn scope rõ.

## Kiểm tra

Network mất giữa download, cancel/resume, retry idempotent, disk full, integrity error, asset mismatch, app restart, local removal khi đang play, transcript-only fallback và screen reader announcement không mỗi byte.
