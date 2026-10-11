# Compose · Landing page

Mục tiêu: giải thích giá trị Vi Learn và cho nghe thử có chủ động. Bám typography và whitespace OneNotch, giữ CTA đen, accent tím iris nhỏ, nét viết tay và imagery ấm của bản Vi Learn đầu tiên.

## Composition

[Navbar](../component/navbar.md) → hero display + body-large + [Button](../component/button.md) → [Audio player](../component/audio-player.md) preview → [Topic card](../component/topic-card.md)/[Lesson card](../component/lesson-card.md) → các [Card](../component/card.md) giải thích nghe/transcript/lưu từ → [Accordion](../component/accordion.md) FAQ → CTA/footer links.

Hero tham chiếu 40/56/72/80px, container-wide, section gap84/110/140. CTA56px pill, mobile có thể full-width; text viết tay chỉ optional decoration, không label action. Mockup player là UI thật hoặc được ghi rõ sample; không giả audio thu thật khi dùng TTS.

## Hành vi

CTA khám phá là link nếu đi route; Nghe thử là button gọi playback qua controller. Người dùng khởi động audio; một player chạy; switching sample pause source cũ. Navbar anchor không che section. FAQ single-open theo nguồn, nhưng error/essential terms không giấu trong FAQ.

## State coverage

Preview ready/loading/buffering/error/unsupported; lỗi âm thanh vẫn cho xem transcript. Topic/lesson dataset mẫu phải ghi rõ nếu chưa là catalog thật. Không dựng testimonial, số người dùng, pricing hoặc discount không có dữ liệu. Nút thử không hứa đăng ký/cài đặt nếu chưa có route đó.

## Không dùng

Không scroll hijack nhiều viewport-height, autoplay âm thanh, animation loop hoặc glass lens phức tạp chỉ để giống site nguồn. Không nội dung quan trọng chỉ nằm carousel. Không hard-code light color khi người dùng chọn dark.

## Kiểm tra

320→1440px, font fallback, keyboard mobile nav, CTA đúng ý định, audio unavailable, reduced motion, contrast trên mockup. Landing phải hiểu được khi không chạy animation và không tải cover.
