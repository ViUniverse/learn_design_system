# Token và theming

Trạng thái: new/adapted. [JSON](../tokens/design-tokens.json) là nguồn; [CSS](../tokens/design-tokens.css) là output sinh tự động. JSON portable của Vi Learn, không tuyên bố tuân thủ định dạng DTCG.

## Lớp token

Primitive: neutral/violet ramp, số spacing/radius/motion. Semantic: màu theo vai trò và theme, typography role, control size, container, layer. Component áp semantic vào slot; một property chỉ có số riêng khi file component quy định rõ. Không phải mọi số trong spec gốc OneNotch là primitive của Vi Learn.

## Web

```html
<link rel="stylesheet" href="tokens/design-tokens.css">
<html data-theme="dark">
```

Hai dòng minh họa hai vị trí khác nhau: link đặt trong head, data-theme đặt trên html. Dùng `--vl-primary`, `--vl-on-primary`, `--vl-space-4`… Khi không có data-theme, CSS theo `prefers-color-scheme`. Nếu có light/dark rõ, lựa chọn đó thắng OS. Ứng dụng chịu trách nhiệm lưu lựa chọn và đặt attribute trước paint để tránh flash, xử lý “system” bằng cách xóa attribute.

```css
.lesson-action {
  background: var(--vl-primary);
  color: var(--vl-on-primary);
  min-height: var(--vl-size-control-md);
  border-radius: var(--vl-radius-pill);
}
```

Media queries không đọc CSS custom property cho breakpoint; build tool dùng giá trị số từ JSON. Các role marketing có override ở 735/1069/1441px, app role giữ scale cho text settings.

## Flutter

Tạo adapter theme ở presentation/app brand, đổi CSS px thành logical px tham chiếu, dùng text scaling của Flutter. Parse hex RGBA tám chữ số thành đúng ARGB khi đưa vào Color, không đọc nguyên số là ARGB. Theme extension và Material ColorScheme phải đồng bộ; import package shared qua public API. App giữ locale/font assets và theme preference.

## Không dùng khi nào

Không chỉnh CSS sinh rồi bỏ JSON lệch. Không đưa Vi Learn palette vào vi_foundation hoặc domain. Không dùng alias text-primary làm màu fill nút rồi suy ra foreground. Không có dark theme bằng CSS invert.

## Kiểm tra

Chạy build và validator, xác nhận theme có cùng key set, alias không thiếu, alpha giữ chính xác. Theme đổi trong overlay và player mà không reset value/focus/playback. Nếu cần Figma, nhập giá trị JSON theo collection Light/Dark; hiện chưa tạo hoặc đẩy file vào Figma.
