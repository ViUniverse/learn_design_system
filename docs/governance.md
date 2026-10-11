# Governance và phát triển bộ thiết kế

## Trạng thái phiên bản

Phiên bản trong manifest là phiên bản của **đặc tả**, không tương đương phiên bản package Flutter hay release sản phẩm. Mỗi catalog item có một Markdown contract. Pattern là composition, không public component thứ hai. Các token có numeric/color source rõ; dark theme mới là thiết kế Vi Learn.

## Khi thêm/sửa

1. Nêu nhiệm vụ người dùng và bằng chứng component hiện có chưa đáp ứng.
2. Thêm component entry ở `tools/component_specs.py` với mục đích, anatomy, geometry, variants, states, use/avoid, props, keyboard, responsive, example, checks, related.
3. Chỉ thêm foundation token khi có trách nhiệm rõ; ưu tiên semantic key hiện có. Giữ key set light/dark bằng nhau.
4. Sinh lại Markdown/token CSS, kiểm tra links/coverage/contrast; ghi thay đổi thiết kế trong changelog release tương ứng.
5. Khi triển khai widget, thực hiện checklist riêng trong component, including keyboard/screen reader/touch, thay vì dùng validator docs như bằng chứng hành vi.

## Breaking changes

Đổi ý nghĩa token, bỏ key, thay keyboard contract, đổi ownership state hoặc component purpose là breaking. Điều chỉnh spacing nhỏ có thể patch nhưng cần visual QA. Thêm variant/token tương thích là minor. Không sửa generated Markdown trực tiếp rồi quên update source.

## Ranh giới repo

Theme, control và composition thuộc `learn_design_system`; dữ liệu nội dung, controller phiên nghe và persistence thuộc app/domain. App import public entrypoint; domain không import theme/widget. `foldable_info` cung cấp số đo, design system sở hữu policy layout. Không phục hồi dependency vào Vi UI cũ. Trong ViAce, package là member native pub workspace với `resolution: workspace`; bản GitHub đứng độc lập và không khai báo resolution này.

## Done cho đặc tả

- Coverage manifest khớp file thực; không link/token thiếu; JSON/CSS đồng bộ.
- Foundation có cách dùng, tránh dùng và tiêu chí kiểm tra.
- Từng component có dữ liệu, trạng thái, keyboard, responsive, trường hợp dùng/tránh và ví dụ cụ thể.
- Luồng nghe học/marketing được ghép bằng catalog hiện tại, không viện đến component chưa định nghĩa.
- Sources phân biệt observed/adapted/new; hạn chế nguồn được giữ lại.

## Done cho implementation tương lai

Tests behavior theo rủi ro thật; visual light/dark compact/expanded; assistive tech trên nền tảng mục tiêu; localization/text scaling; không network/storage trong component; data/state thực phản ánh engine/controller; privacy/authorization thuộc app đúng scope. Người triển khai lưu evidence rồi cập nhật trạng thái implementation, không tự động đánh hoàn thành từ manifest.
