# Media và nội dung nghe

Trạng thái: new. Cơ sở [WAI media](https://www.w3.org/WAI/media/av/); policy nghe học của Vi Learn mở rộng cho transcript và từ vựng.

## Mô hình

App sở hữu media session: idle, loading, ready, playing, paused, buffering, ended, error. Player chỉ nhận state và callback; không đồng thời mở nhiều audio session. Transcript phải đọc được cả khi âm thanh chưa tải. Download state là mô hình riêng, không suy ra từ buffering.

## Điều khiển

Không autoplay. Play/pause, seek, elapsed/duration, speed và lỗi phải có tên/giá trị đọc được. Native range hoặc equivalent platform semantics cho seek. Timer visual cập nhật theo playback, nhưng live region chỉ báo chuyển trạng thái có ý nghĩa. Khi duration chưa biết, seek disabled có lý do; không hiển thị 0:00 / 0:00 như bài kết thúc.

Playback speed đề xuất 0.75×/1×/1.25×/1.5×/2×, app có thể cung cấp tập hỗ trợ thực. Không giả giữ cao độ nếu engine không hỗ trợ. Nguồn audio (thu thật/TTS) phải mô tả chính xác. Speech synthesis là phương án preview khi có hỗ trợ, không thay thế bắt buộc cho mọi audio asset.

## Transcript

Gắn stable segment ID và timestamps khi có. Nếu không có timing, hiển thị text tĩnh và bỏ lời hứa sync. Auto-follow mặc định chỉ khi người dùng chủ động bật hoặc chọn mode follow; thao tác scroll/read dừng follow và cung cấp nút trở lại đoạn đang nghe. Chọn từ không làm jump playback nếu chưa yêu cầu.

## Không dùng khi nào

Không coi waveform là transcript thay thế. Không animate fake waveform để báo playing nếu engine bị buffering. Không tự seek khi đổi theme hoặc mở popover. Không nhận microphone permission chỉ vì mở bài nghe; ghi âm là action tách riêng có giải thích.

## Kiểm tra

Keyboard seek, screen reader, interrupted playback, audio focus hệ điều hành, tab nền, source changed, duration unknown, audio unavailable, transcript-only, offline và failed download. Với nội dung audio-only cung cấp transcript theo yêu cầu tiếp cận áp dụng; caption cho video không tự động được coi là transcript đầy đủ.
