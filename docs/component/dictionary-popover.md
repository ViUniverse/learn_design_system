# Dictionary popover

Nhóm: Learning · Phiên bản 1.3.0 · Trạng thái: đặc tả thiết kế, chưa phải widget/API sản xuất.

## Mục đích và phạm vi

Tra nghĩa theo từ/phrase và ngữ cảnh mà vẫn giữ vị trí đọc transcript.

## Cấu tạo

Selected phrase anchor; title; pronunciation; action thêm từ gần title; meaning; contextual example; source/provider attribution; close.

## Thông số và token

Surface-raised/radius-panel, width320 max viewport-32, padding16/24; word h3; actions44; selected text pair.

Tên màu/size viết trong tài liệu là semantic key của [design-tokens.json](../tokens/design-tokens.json). Trên web thêm prefix `--vl-`; mapping Flutter nằm ở theme adapter presentation. Không hard-code palette light khi chuyển dark. Text nở theo nội dung; kích thước là min/max tham chiếu, không cắt chữ để giữ geometry.

## Biến thể

anchored nonmodal desktop; modal bottom sheet mobile; cached/offline meaning khi có provenance.

## Trạng thái và chuyển trạng thái

Closed/loading/ready/no-entry/error/saving/saved. Query context giữ rõ; stale response không hiển thị cho term khác.

State/value do app cung cấp. Callback chỉ biểu đạt ý định; app xác nhận kết quả async, xử lý rollback/retry và giữ ID ổn định. Đổi theme không làm reset giá trị, trạng thái lựa chọn, nháp hoặc playback. Với component chỉ hiển thị, không tự thêm hover/focus/loading không có nghĩa.

## Khi nên dùng

- Chọn phrase trong transcript.
- Tra từ library.
- Nghĩa có ngữ cảnh bài nghe.

## Không được dùng khi nào

- Không tooltip chứa action.
- Không gửi toàn transcript cloud mặc định.
- Không hiện nghĩa bịa khi service lỗi.
- Không làm playback restart.

## Thêm từ trong ngữ cảnh

- Khi chạm từ, mở nội dung từ/nghĩa/ngữ cảnh trực tiếp; nút **Thêm vào từ điển** phải nhìn thấy trước khi cuộn. Không bắt người dùng nhập lại từ hoặc đi qua form tra cứu.
- No-entry vẫn cho lưu term + source + câu gốc. Hiển thị chưa có nghĩa, không tạo nghĩa giả. Lưu trùng là idempotent theo identity của app.
- Trong prototype, xác nhận **Đã thêm trong phiên mẫu**; không mô tả là đã lưu bền vững. Bản production chỉ xác nhận sau repository thành công và có rollback/retry khi lỗi.
- Mobile sheet cao theo nội dung với max viewport; có thể cuộn và tránh bàn phím, không mặc định chiếm78% màn hình cho mọi từ ngắn.
- Đường tra cứu nhập tay qua trigger từ điển hoặc **Tra từ khác**. Tra/lưu không seek hoặc autoplay; chỉ **Nghe câu gốc** phát câu theo action tường minh.

## Cách dùng và hợp đồng

1. Chọn biến thể theo ý định nêu trên, không chỉ theo hình thức.
2. Cung cấp dữ liệu có ID ổn định, label đã localization và các callback cần thiết; [model chung](../contracts.md) mô tả các kiểu.
3. Đặt component vào container thích hợp, ghép feedback/helper/action được chỉ định; ứng dụng sở hữu network, storage, route và validation nghiệp vụ.
4. Kiểm tra các tình huống riêng ở cuối tài liệu trước khi coi implementation hoàn tất.

| Thuộc tính đặc tả | Kiểu | Mặc định / yêu cầu |
| --- | --- | --- |
| `term` | `string` | bắt buộc |
| `context` | `string|null` | null |
| `entry` | `DictionaryEntry|null` | null |
| `status` | `enum` | loading |
| `saved` | `boolean` | false |
| `onSave` | `callback` | bắt buộc |
| `onClose` | `callback` | bắt buộc |

### Ví dụ cấu hình / nội dung

```json
{
  "term": "slow down",
  "context": "We need to slow down.",
  "entry": {
    "meaning": "chậm lại",
    "source": "Từ điển cục bộ"
  },
  "status": "ready",
  "saved": false
}
```

Ví dụ là hợp đồng trung lập framework và có thể gồm label/content của composition; không phải lệnh gọi một SDK đã tồn tại. Thay sample IDs/routes/assets bằng dữ liệu ứng dụng. Callback không xuất hiện trong JSON vì do controller của app truyền vào; không suy ra hành động thành công chỉ từ cấu hình mẫu.

## Bàn phím và semantics

Đường accessible: chọn text/trigger Tra từ; interactive popover focus hợp lý, Esc đóng trả anchor/trigger; modal mobile theo Dialog; text đọc tự nhiên.

Accessible name phải khớp nhãn nhìn thấy; icon trang trí không tạo node đọc dư. Trạng thái quan trọng có text/semantic, không chỉ màu. Không thêm positive tabindex hoặc autofocus khi dữ liệu nền cập nhật. [Foundation accessibility](../foundation/interaction-accessibility.md) là baseline; quy tắc riêng ở đây ưu tiên khi có ngữ cảnh cụ thể.

## Responsive, localization và motion

Sheet khi selection anchor ngoài viewport; không mất selected context; nghĩa dài scroll trong panel với close nhìn được.

Kiểm tra 320px và text scaling 200%; dùng `lang` cho nội dung khác ngôn ngữ UI. Respect reduced motion; bỏ chuyển động trang trí mà không mất trạng thái. Hover không là điều kiện duy nhất để nhìn thấy hoặc dùng action.

## Tiêu chí nghiệm thu

- Multiword selection.
- Stale request.
- Offline/no-entry.
- Save rollback.
- Focus restore.
- Cloud action opt-in/data scope rõ.

Các tiêu chí này là yêu cầu kiểm thử cho implementation. Validator của bộ tài liệu kiểm tra coverage/link/token/contrast, không xác nhận hành vi screen reader hoặc runtime của component chưa được triển khai.

## Liên quan và nguồn

[popover](./popover.md) · [drawer](./drawer.md) · [vocabulary-card](./vocabulary-card.md) · [transcript](./transcript.md)

Tham khảo pattern: [WAI Media](https://www.w3.org/WAI/media/av/). Visual style, dữ liệu nghe học và contract do Vi Learn bổ sung; [provenance](../research/sources.md) phân biệt phần trích xuất và phần thiết kế mới.
