# Content và localization

Trạng thái: new. Vi Learn có UI tiếng Việt và nội dung học có thể tiếng Anh hoặc ngôn ngữ khác.

## Giọng và cấu trúc

Nói trực tiếp, bình tĩnh, một ý mỗi câu. Action dùng động từ cụ thể: “Nghe bài”, “Lưu từ”, “Thử tải lại”. Trạng thái nói sự thật: “Chưa tải được âm thanh” thay vì “Có gì đó sai”. Hướng dẫn sửa nằm cạnh lỗi. Không tạo cảm giác tội lỗi khi người dùng bỏ một ngày học.

| Trường hợp | Dùng | Tránh |
| --- | --- | --- |
| Bài trống | Chưa có bài đã lưu. Khám phá bài nghe. | Không có gì! |
| Mất mạng | Bạn đang ngoại tuyến. Bài đã tải vẫn nghe được. | Lỗi hệ thống |
| Lưu từ | Đã lưu “slow down”. | Thành công |
| Loading | Đang tải bản chép lời… | Vui lòng kiên nhẫn vô hạn |
| Completion | Bạn đã nghe xong bài này. | Bạn đã thành thạo tiếng Anh |

## Dùng như thế nào

Tách key UI khỏi lesson text. Gắn `lang` cho đoạn tiếng Anh và tiếng Việt; không giả mọi token từ vựng có cùng ngôn ngữ với giao diện. Format số/ngày theo locale; duration nghe dùng mm:ss/h:mm:ss có nhãn đầy đủ cho screen reader. CEFR viết A1–C2 có giải thích ở onboarding/help, không tự đổi level dựa theo theme.

Label chịu được độ dài tăng 30–50%; không nối chuỗi để tạo câu đa ngôn ngữ. Các thao tác quan trọng không dùng emoji thay chữ. Title card có thể clamp hai dòng nếu còn đường đọc tên đầy đủ, nhưng errors và instruction không truncate.

## Không dùng khi nào

Không uppercase cả đoạn Việt dài. Không dùng chữ viết tay cho nghĩa từ hoặc label. Không gọi speech synthesis là giọng bản ngữ do người thật thu nếu nguồn không phải vậy. Không dùng lời hứa “AI đã hiểu bạn” thay cho mô tả chức năng và phạm vi dữ liệu.

## Kiểm tra

Strings với dấu Việt, tên dài, plural/zero, trạng thái mạng và locale ngược chiều. Buttons không bị co đến khó đọc; thời gian không mang dấu phân cách sai; focus/screen reader đọc đúng ngôn ngữ cho từng đoạn.
