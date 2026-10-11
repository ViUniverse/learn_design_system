# Spacing và kích thước

Trạng thái: adapted. Source CSS có nhiều số lẻ; Vi Learn chuẩn hóa để triển khai nhất quán. Nguồn: `spacing`, `size`, `layout` trong [JSON](../tokens/design-tokens.json).

## Scale

`space-0/0-5/1/2/3/4/5/6/8/10/12/16` tương ứng 0/2/4/8/12/16/20/24/32/40/48/64px. Các bước 84/110/140px dành nhịp section marketing, không dùng làm gap form. Tên token là multiplier lịch sử của 4px, không suy ra số bằng parsing tên.

## Dùng như thế nào

- Icon–label: 8px. Label–input: 8px. Helper/error cách input 4–8px.
- Form field–field: 20–24px. Nhóm hành động: 8–12px.
- Card padding: compact 16px, standard 24px, feature 32px; nội dung rất hẹp giảm về 16px.
- Grid gap: 24px, compact 16px. Section app: 32–48px; section marketing: 84/110/140px.
- Control visual small 32px, medium 44px, large CTA 56px; vùng tương tác tối thiểu 44px. Small chỉ ở desktop/dense toolbar có hit region riêng và không chồng target lân cận.
- Icon 16/20/24/32px; không dùng icon 44px chỉ để đạt hit target.

Dùng logical properties (`padding-inline`, `gap`) để localization không cần đổi từng margin. Độ dài label quyết định min-width; full-width CTA mobile chỉ trong form/hero có hành động rõ, không kéo toàn bộ button của toolbar.

## Không dùng khi nào

Không thêm spacer rỗng để sửa thiếu cấu trúc. Không áp min-height thành height cố định cho control có nhiều dòng. Không dùng hit region vô hình vượt vào target khác. Không áp khoảng cách marketing 140px vào màn hình nghe.

## Kiểm tra

Ở 320px, không có nút hoặc hit region đè nhau. Test chuỗi dài, 200% text scaling, loading button và touch. Layout vẫn rõ grouping nếu bật outline tất cả hộp; spacing không phải dấu hiệu duy nhất của quan hệ form, phải có label/fieldset.
