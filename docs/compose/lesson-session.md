# Compose · Phiên nghe và transcript

Mục tiêu: nghe, đọc ngữ cảnh, tra và lưu từ trong cùng session ổn định.

## Composition

[Breadcrumb](../component/breadcrumb.md) → title/metadata → [Audio player](../component/audio-player.md) gồm [Seek bar](../component/seek-bar.md)/[Speed control](../component/speed-control.md) → [Tabs](../component/tabs.md) khi cần phân panel → [Transcript](../component/transcript.md) → [Dictionary popover](../component/dictionary-popover.md)/[Vocabulary card](../component/vocabulary-card.md).

App sở hữu một media session. Khi đi sang màn khác, [Mini player](../component/mini-player.md) nhìn cùng state; không mở engine mới. Metadata không thay đổi elapsed/source khi cập nhật ảnh hoặc theme.

## Tương tác chuẩn

1. User Play; engine xác nhận playing hoặc lỗi.
2. Seek preview trong drag, commit range value; callback tới engine, UI chờ/nhận actual state.
3. Current transcript chỉ highlight theo timestamp phù hợp version. Follow không tự kéo khi user đang đọc/scroll đoạn khác.
4. Chọn phrase → Tra từ; popover có context/source, mở không tự seek.
5. Save word pending → confirmed saved hoặc error/rollback. Khi có cloud lookup, app hỏi opt-in/phạm vi theo policy; không UI gửi transcript mặc định.

## State coverage

Loading metadata khác buffering audio; transcript-only đọc được khi audio lỗi; duration unknown disable seek, không fake0:00/0:00; no-entry dictionary khác service error. Source version mismatch bỏ sync và báo text-only thích hợp.

## Không dùng

Không global Space chiếm typing trong note, live region toàn transcript/timer, every-word Tab stop hoặc waveform giả khi playing. Không diễn giải hoàn thành nghe là đã thông thạo.

## Kiểm tra

Play rejected, pause/resume, end/restart, source changed, background tab, network drop, speed unsupported, seek keyboard/touch AT, dictionary stale request, focus close/restore, language switching, zoom và reduced motion.
