# Compose · Onboarding

Mục tiêu: chọn sở thích và mục tiêu đủ để bắt đầu; không biến đăng ký thành form dài.

## Composition

[Stepper](../component/stepper.md) 2–3 bước → [Radio group](../component/radio-group.md) trình độ/mục tiêu → [Topic card](../component/topic-card.md) selectable hoặc [Checkbox](../component/checkbox.md) sở thích → [Button](../component/button.md) tiếp tục/bắt đầu. [Form field](../component/form-field.md) cung cấp legend/helper/error.

Container-form480px với text đủ rộng; level A1–C2 có giải thích. Nếu chưa biết trình độ, lựa chọn “Chưa chắc” là value domain được hỗ trợ, không ép tự đánh giá sai. Mục tiêu phút là chọn lựa tham khảo, có thể chỉnh sau.

## Hành vi

Step state do app giữ, Back không xóa lựa chọn. Completed chỉ sau validation bước; khi next step mở focus heading hợp lý. Topics multi-select dùng checkbox semantics, không radio. Tùy chọn AI cloud/notification/microphone không gộp vào Bắt đầu; yêu cầu khi action thật cần dùng.

## State coverage

Pristine/selected/invalid/submitting/error; không timeout bắt hoàn thành nhanh. Optional steps cho skip nếu product cho phép. Form data giữ khi network không có; backend policy auth/user scope thuộc app.

## Không dùng

Không checkbox prechecked cho consent nhạy cảm; không xin microphone chỉ để nghe; không dùng radio card lồng link; không Stepper giả nếu tất cả chỉ là một form ngắn.

## Kiểm tra

Keyboard radio/checkbox, long descriptions, validation error summary, back/forward state, reload draft theo privacy policy, no network retry, starting default có nghĩa và text scaling.
