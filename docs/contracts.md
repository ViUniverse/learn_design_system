# Hợp đồng và model chung

Các tên ở đây là contract thiết kế trung lập framework, không phải class đã triển khai. Mỗi implementation có thể đặt tên theo stack nhưng phải giữ ý nghĩa, trạng thái và ranh giới sở hữu. Callback không được thay bằng network call bên trong widget.

## Kiểu cơ bản

| Kiểu | Cấu trúc / điều kiện |
| --- | --- |
| `string`, `number`, `boolean` | Giá trị đã chuẩn hóa theo domain; `0`, `false`, `""` khác `null` |
| `ISO-date` | `YYYY-MM-DD`, date-only không chuyển timezone như timestamp |
| `timestamp` | Instant có timezone rõ; format hiển thị theo locale app |
| `url` | Route hoặc URL đã kiểm tra scheme; không thực thi `javascript:` từ content |
| `icon-id` | Mapping của bộ glyph có phiên bản; accessible name không suy ra từ ID |
| `slot`, `existing-control` | Presentation composition; semantics của child được giữ |
| `target` | Focus target theo ID/ref trong scope hiện tại; không selector tới vùng nền đang inert |
| `callback` | App handler nhận intent và ID/value; app xác nhận async result |
| `enum` | Một trong các biến thể/trạng thái được liệt kê trong file component |

## Model phổ thông

| Model | Thuộc tính và nghĩa |
| --- | --- |
| `Option` | `value` stable string, `label`, optional `description`, `disabled`; label không làm ID |
| `Action` | `id`, `label`, optional `icon`, `tone`, `disabled`, `reason`; callback do app truyền riêng |
| `NavItem` | `label`, `href`, optional `icon`, `current`, `disabled`; route mapping nằm ở app |
| `NavGroup` | `id`, `label`, `links: NavItem[]`, optional collapsed; group label không click điều hướng nếu chỉ grouping |
| `Tab` | `id`, `label`, `panelId`, optional disabled, content slot; tab/panel association một-một |
| `Step` | `id`, `label`, state `upcoming/current/completed/error/blocked`, optional reason; current chỉ một |
| `MenuItem` | `id`, `label`, kind `action/checkbox/radio/separator`, checked/disabled khi phù hợp; separator không action |
| `BreadcrumbItem` | `label`, optional `href`; current là item cuối có aria-current |
| `AccordionItem` | `id`, `title`, `content`, optional disabled; open state thuộc group |
| `Person` | `id`, `name`, optional `avatarUrl`, `status`; không tạo người giả |
| `Slide` | `id`, `title`, media/content, accessible description; active slide do index/ID ổn định |
| `Control` | Action/control presentation có name/handler; toolbar không thay semantics child |
| `ListItem` | `id`, `title`, optional metadata/media/href/actions; selection là value riêng |
| `Column` | `id`, `label`, data accessor, optional unit/alignment/sortable; không dùng index làm key |
| `Row` | Stable `id` và fields theo column contract của app |
| `Sort` | `columnId`, direction `ascending/descending`; source data phải khớp header state |
| `FileState` | `id`, `name`, `mime`, `bytes`, transfer state, optional loaded/total/error; selected khác transferred |

Các JSON example trong component có thể rút gọn `options` thành label hoặc dùng ID của content slot nhằm minh họa composition. Implementation phải chuyển thành model chuẩn, không coi các mẫu rút gọn là validation schema của SDK.

## Model nghe học

### Media session

`sessionId`, `lessonId`, `sourceId/version`, state, elapsed/duration, supportedRates, speed, buffered ranges và error/capabilities. Controller app sở hữu engine; Audio player và Mini player chỉ là hai view. Source changed làm reset timeline theo policy domain; theme changed không đổi source.

Không suy ra elapsed từ tiến độ download. `durationSeconds: null` là unknown. Chỉ show seek khi có duration hợp lệ và capability seek; nếu duration bằng 0 hoặc media unseekable, thông báo phù hợp và disable control.

### Segment

`id`, `text`, `lang`, optional `start/end` seconds, `translation`, `translationLang`, `sourceVersion`. ID ổn định theo bản transcript. `0 ≤ start < end ≤ duration` khi duration biết; segments sắp theo timeline và tránh overlap ngoài policy. Chưa có alignment thì text-only; không generate thời gian giả.

### WordTiming

Segment có optional `words: WordTiming[]`. Mỗi word có `text`, `start/end` giây tuyệt đối trong media, `startOffset/endOffset` theo UTF-16 trong nguyên văn của segment. Range text phải khớp chính xác, sắp thứ tự, không overlap; `0 ≤ start < end` hữu hạn và nằm trong cue khi cue timing có sẵn. Gap hợp lệ. Word identity có thể suy ra từ stable segment ID + text range; không lấy spelling làm identity vì từ có thể lặp lại.

Karaoke dùng interval `[start,end)`, tách khỏi active cue dùng lặp/seek/follow. Dữ liệu không khớp phải fallback, không nội suy timestamps từ thời lượng câu. Provider adapter nằm trong data của app, không trong domain/widget.

### DictionaryEntry

`term`, `language`, senses/meaning, optional pronunciation/example, `source`, `generated` flag, cachedAt/sourceVersion. Nghĩa do AI sinh phải được mô tả đúng và theo chính sách opt-in; không mặc định gửi toàn transcript. App giữ authorization và provider abstraction.

### Vocabulary / Review

Vocabulary identity bao gồm term + language + context/source theo domain, không chỉ lowercase từ. Saved status phải dựa persistence. Review item có itemId, prompt/answer, mode, reveal state, response/result và opId chống duplicate nếu đồng bộ. Grade policy thuộc domain, component không tính mastery.

### Download

Per lesson/sourceVersion: queue state, asset set bắt buộc/tùy chọn, loaded/total bytes, integrity state, error, capabilities retry/cancel/remove. Available sau xác nhận assets cần thiết. Partial cached audio không đồng nghĩa offline complete.

## Events và sở hữu

UI phát intent `activate`, `valueChange`, `submit`, `openChange`, `seekPreview`, `seekCommit`, `save`, `retry`, `downloadAction`, `grade`. Controller app xác nhận kết quả, giữ revision/opId khi domain đồng bộ yêu cầu. Component không log secret, không tự mở microphone hoặc gửi cloud. Sự kiện text change không được làm request mạng không kiểm soát.

## Tiêu chí hợp đồng

Chuyển giá trị từ ngoài cập nhật UI đúng; stable ID giữ selection/focus; callbacks gọi một lần mỗi intent; async response cũ bị app loại bỏ; error/unknown/zero có nghĩa riêng; serialization không bao gồm callback/engine/private credentials.
