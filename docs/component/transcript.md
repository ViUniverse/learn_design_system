# Transcript

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Nội dung chữ của bài nghe, đọc độc lập và có thể đồng bộ karaoke theo từng từ khi có word timestamps; segment vẫn là đơn vị điều hướng/lặp câu.

## Cấu tạo

Region title; language controls; segment rows; timestamp; original text; optional translation; current marker; follow toggle.

## Thông số và token

Type-transcript18/1.7, reading max760, timestamp gutter52 với target48; text padding8 dọc,4/8 ngang; current word dùng selected pair + underline, current cue có marker ở lề; translation small/body, không mờ dưới chuẩn.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

plain text; sentence-timed navigation; word-timed karaoke; bilingual; follow mode opt-in. Không có timestamps dùng plain.

## Trạng thái và chuyển trạng thái

Loading/ready/error; active segment và active word là hai trạng thái riêng; selected text; follow paused bởi manual reading/scroll; translation unavailable có thông báo.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Lesson detail.
- Học theo câu.
- Đọc bài offline.
- Phục vụ nội dung audio-only khi cần transcript.

## Không được dùng khi nào

- Không live-read cả paragraph mỗi giây.
- Không tự seek khi chọn từ.
- Không auto-scroll cướp focus.
- Không invent timing hoặc translation.

## Karaoke theo từ và mật độ đọc

- Cỡ chữ18/1.7, weight ổn định; không tăng cả câu lên22/bold khi phát. Thời gian ở lề, không chiếm một hàng riêng. Gom Lặp câu/Dịch câu vào menu công cụ ở header, không lặp action footer trong mỗi đoạn.
- Khi có timing hợp lệ, chỉ từ với `start ≤ position < end` được highlight. Khoảng im lặng không highlight. Không suy ra word timing bằng chia đều thời lượng câu.
- Dữ liệu word timing gồm text, start/end giây tuyệt đối, startOffset/endOffset trong nguyên văn; xem [model chung](../contracts.md). App mapper chuyển dữ liệu ASR vào domain, widget không biết provider.
- Timestamp sai/thiếu/không khớp nguyên văn phải fallback sang lời đọc thường hoặc điều hướng theo cue khi cue timing vẫn hợp lệ.
- Chỉ cue đang nghe cập nhật theo đồng hồ media; không tạo timer riêng cho từng row, không live-announce từng tick. Highlight không đổi metrics chữ hoặc kéo scroll khi follow tắt.
- Chạm từ mở nghĩa/ngữ cảnh và action **Thêm vào từ điển** ngay cả khi chưa có nghĩa. Giữ selection native và đường tra cụm từ bằng bàn phím.
- Kiểm tra với font thật: khung390×844 và player pane trong852×884 phải thấy ít nhất4 câu mẫu trọn vẹn ở text scale100%, song ngữ tắt. Với200% giữ chữ và cho cuộn, không ép đạt cùng số câu.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `segments` | `Segment[]` | bắt buộc |
| `activeId` | `string|null` | null |
| `positionSeconds` | `number|null` | null; dùng chung media clock |
| `follow` | `boolean` | false |
| `showTranslation` | `boolean` | false |
| `onSeekSegment` | `callback|null` | null |
| `onWordSelect` | `callback|null` | null |

### Ví dụ cấu hình / nội dung

```json
{
  "segments": [
    {
      "id": "s1",
      "start": 0,
      "end": 5,
      "text": "Sometimes we need to slow down.",
      "translation": "Đôi khi chúng ta cần chậm lại.",
      "lang": "en"
    }
  ],
  "activeId": "s1",
  "follow": false,
  "showTranslation": true
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Text selection native; timestamp/Nghe câu là button riêng; không mọi từ thành Tab stop. Dictionary có đường chọn text + action Tra từ accessible.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Original/translation stack; không bảng2cột cố định; heading/player không che active/focused segment; user có Trở lại đoạn đang nghe.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- No timestamps fallback.
- Word boundaries/gaps, seek ngược, speed và loop không highlight sai từ.
- Typography/reading anchor ổn định khi đổi active word.
- Scroll stops follow.
- Select text không play.
- Language announcements.
- Active+focus separate.
- Source mismatch timing reject.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[dictionary-popover](./dictionary-popover.md) · [audio-player](./audio-player.md) · [switch](./switch.md)

Tham khảo pattern: [WAI Media](https://www.w3.org/WAI/media/av/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
