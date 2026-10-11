# Shape và border

Trạng thái: adapted. Nguồn: `radius`, `borderWidth` trong [JSON](../tokens/design-tokens.json).

## Scale

xs 4px cho highlight inline; sm 8px cho chip nhỏ; md 12px cho input/menu item; lg 16px cho menu và hình; card 20px; panel 24px; feature 28px; hero 32px; pill 9999px cho CTA/chip chọn. Radius là ngôn ngữ phân cấp, không phải dùng mọi mức trong cùng màn hình.

## Dùng như thế nào

Card ứng dụng dùng 20px, panel/player 24px; feature marketing 28px và khung hero 32px. Input 12px. Control pill vẫn có chiều cao tối thiểu và padding inline. Border mặc định 1px; control strong/focus 2px. Khi focus có offset, không thay độ dày border trong layout để tránh nhảy kích thước.

Lồng ảnh trong card giữ radius hợp lý với inset: ví dụ card 20px, padding 16px, thumbnail 12px. Nền dark vẫn có border-subtle để thấy ranh giới bề mặt. Divider không được thay cho label hoặc vùng nhóm semantic.

## Không dùng khi nào

Không làm mọi block thành pill. Không dùng clip-path notch như mặc định: nguồn đó thuộc sản phẩm OneNotch. Không cắt focus ring vì `overflow:hidden` của container; chỉ clip ảnh bên trong. Không đổi border transparent thành 2px khi hover nếu chưa dành chỗ.

## Kiểm tra

Card/light/dark có hierarchy nhất quán, input nhận biết rõ trước focus, ring nhìn được ở tất cả cạnh. Text nhiều dòng không chạm đường cong của pill. Target nằm trong radius visual nhưng không bị thu nhỏ thành hình tròn khó bấm.
