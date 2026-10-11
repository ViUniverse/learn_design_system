# Vi Learn showcase

Website HTML cục bộ cho Learn Design System 1.2. Có overview, palette light/dark, demo cho 64 component, 16 foundation và 7 compose. Component HTML minh họa đặc tả; chưa phải thư viện widget Flutter production.

## Chạy

Từ thư mục package:

```sh
python3 -m http.server 18769 --bind 127.0.0.1 --directory docs
```

Mở `http://127.0.0.1:18769/showcase/`. Không cần cài dependency hoặc build.

## Cập nhật dữ liệu

Sau khi chỉnh spec / token gốc:

```sh
python3 docs/showcase/build_catalog.py
```

[Catalog](catalog.js) lấy dữ liệu từ manifest, token JSON và đặc tả gốc. [Stylesheet](styles.css) dùng semantic token trong [CSS gốc](../tokens/design-tokens.css). Nâng query version trong [HTML](index.html) khi cần làm mới cache của preview.

## Demo

- Theme được ghi nhớ cục bộ trong trình duyệt.
- Nghe thử dùng speech synthesis nếu thiết bị hỗ trợ. Nội dung mẫu không phải audio sản phẩm; waveform là trang trí, seek bar là mẫu control độc lập.
- Các tác vụ lưu, ôn và download minh họa phản hồi UI, không ghi dữ liệu sản phẩm.
- File picker chỉ hiện tên file, không upload.
- Không có dịch vụ backend hoặc phân tích hành vi.

## Kiểm tra bản đầu

Đã mở cả 64 component trên desktop 1280px; tất cả có demo và không tràn ngang. Đã mở 16 foundation / 7 compose, kiểm tra theme 41 swatch mỗi chế độ, lưu playlist trong dialog, tab bằng keyboard, review card và tìm kiếm / tra từ trên mobile 390px. Kiểm tra bổ sung tổng quan ở 410px. Không có lỗi JavaScript được ghi nhận trong phiên kiểm tra. Đây là kiểm tra showcase, không chứng nhận accessibility của implementation sản phẩm.

## Hướng thiết kế 1.1

Khôi phục concept đầu: CTA đen/trắng ấm, accent xanh nhỏ, nền trung tính, SN Pro và nét viết tay. Bản public dùng SN Pro từ font TTF của package và Pecita từ upstream có OFL đi kèm; xem [third-party notices](../../THIRD_PARTY_NOTICES.md).

Đã kiểm tra 126 cặp màu trong token mới; toàn bộ đạt ngưỡng tương phản được quy định trong bộ đặc tả. Showcase cập nhật bảng màu và mẫu code từ cùng nguồn token.

## Accent 1.2

Thay accent xanh bằng tím iris `#705A96` trên light mode, lavender `#C4B2DF` trên dark mode. CTA và nền vẫn dùng neutral.
