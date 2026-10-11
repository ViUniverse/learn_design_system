# Compose · Khám phá bài nghe

Mục tiêu: tìm một bài hợp trình độ/chủ đề và bắt đầu nghe mà không cần nhiều bước.

## Composition

[Navbar](../component/navbar.md)/[Sidebar](../component/sidebar.md) + h1 → [Search](../component/search.md) → [Select](../component/select.md) level và [Topic card](../component/topic-card.md) hoặc filter topic → [Lesson card](../component/lesson-card.md)/[List](../component/list.md) → [Pagination](../component/pagination.md).

Compact một cột; medium hai thẻ nếu đủ width; expanded grid trong1120px, gap24. Metadata gồm level và duration; unknown bỏ hoặc nói rõ, không invent values. Save và Listen là hai action riêng; title đi detail.

## Data flow

Query/filter/page thuộc app controller và có URL/state để quay lại. Reset page khi filter thực sự đổi, không khi theme đổi. Request cũ bị loại; loading giữ context/query, skeleton đúng geometry; kết quả mới có count polite, không giành focus.

## State coverage

[Skeleton](../component/skeleton.md) loading; [Empty state](../component/empty-state.md) first-use hoặc no-results có clear-filter; [Error state](../component/error-state.md) retry giữ query; offline banner chỉ scope thật, bài đã tải vẫn mở được. Partial unknown count không hiển thị total pagination giả.

## Không dùng

Không chỉ carousel cho nhiều bài, không nested interactive whole-card, không ghi “đã tải” từ browser cache tạm. Không bỏ filter label vì placeholder đã có text.

## Kiểm tra

Search với dấu Việt/IME, async stale response, back navigation giữ query/page, keyboard save đúng card, tên bài dài, offline downloaded filtering, empty khác lỗi. Với nhiều kết quả, focus không mất khi item reorder/sort.
