# Compose · Lưu từ và ôn tập

Mục tiêu: giữ phrase theo ngữ cảnh và hỗ trợ nhớ lại, không chỉ sưu tập bookmark.

## Composition

Trong lesson: [Transcript](../component/transcript.md) → [Dictionary popover](../component/dictionary-popover.md) → Save. Library: [Search](../component/search.md)/[Select](../component/select.md) → [Vocabulary card](../component/vocabulary-card.md)/[List](../component/list.md). Review: [Review card](../component/review-card.md) + [Progress](../component/progress.md) + session controls.

Vocabulary identity gồm ngôn ngữ và context/source theo domain. Có thể nhiều nghĩa của cùng term; không tự merge tất cả thành một thẻ. Nghĩa/source AI/local/provider ghi chính xác, không tạo confidence giả.

## Luồng

Save pending không báo success trước persistence. Lưu trùng đưa tới entry sẵn có hoặc giải thích context mới. Review self-assessment hỏi trước, Reveal sau, rồi các action grade có tên rõ; app áp scheduling/mastery policy. Multiple-choice có feedback chữ, không chỉ đỏ/xanh.

Next chỉ sau grade được ghi hoặc trạng thái local-pending được nói rõ; opId chống submit lặp khi sync. Lỗi giữ lượt hiện tại. Completion nói số lượt hoàn tất/đã luyện, không lời hứa thành thạo.

## State coverage

Library loading/empty/error; term unavailable; source removed vẫn giữ câu nguồn nếu policy; no pronunciation; review empty due-set khác no saved words; offline grade pending khác synced.

## Không dùng

Không flashcard flip3D bắt buộc, auto-next khi chưa đọc, giấu đáp án khỏi screen reader bằng màu trắng, hoặc mất nháp/context sau lỗi network.

## Kiểm tra

Long phrase, bilingual/IPA, duplicate save, context differences, review repeat request, keyboard Reveal/Grade/Next, focus mới, offline restart state và nghĩa có nguồn.
