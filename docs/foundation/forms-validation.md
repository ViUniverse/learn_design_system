# Form và validation

Trạng thái: new. Cơ sở [WAI forms](https://www.w3.org/WAI/tutorials/forms/); ứng dụng giữ validation nghiệp vụ.

## Anatomy

Field gồm label, required/optional indicator, control, helper và error. Label luôn tồn tại ngoài placeholder. Nhóm checkbox/radio có fieldset/legend. Form nhiều trường có error summary liên kết tới field lỗi sau submit.

## Thời điểm

Trước submit: helper hướng dẫn, không báo lỗi khi người dùng chưa bắt đầu. Sau blur có thể kiểm tra constraint rõ; không ngắt quá trình gõ bằng lỗi nhấp nháy. Sau submit: giữ dữ liệu, đánh dấu lỗi, focus summary hoặc field lỗi đầu theo quy mô form. Khi sửa field lỗi đã xuất hiện, cập nhật phản hồi hợp lý.

Pending validation không hiển thị success. Trả lỗi server theo field hoặc form chung; không lộ stack trace. Submit pending ngăn double submit; button giữ chiều rộng/label bối cảnh. Readonly cho dữ liệu nhìn/copy được, disabled khi thực sự không thể tương tác, không dùng disabled để giấu lý do.

## Dùng như thế nào

Input nhận value, error, helper, disabled, readOnly và callbacks. Semantic `aria-invalid` bật khi lỗi thực tế, `aria-describedby` tham chiếu helper/error. Các loại input có `autocomplete`, `inputmode`, `type` phù hợp. Email/password nhận tiêu chuẩn browser; secret không đi vào log hoặc toast.

Field width tối đa 480px với form đơn; hai cột chỉ cho trường có quan hệ và đủ bề ngang. Cùng label placement; control 44px tối thiểu, textarea nở theo nội dung. Optional ghi rõ khi form dễ hiểu hơn chỉ dấu sao.

## Không dùng khi nào

Không validate nghiệp vụ trong design system. Không dùng toast là nơi duy nhất báo field sai. Không clear form sau lỗi network. Không ép dropdown cho lựa chọn nhị phân có thể dùng radio/switch đúng ý định. Không xác nhận dialog cho mỗi thay đổi nhỏ có thể undo.

## Kiểm tra

Tab order, error summary link, Enter submit đúng form, thay value từ ngoài, copy/paste/autofill, IME, dấu Việt, mobile keyboard và offline retry. Giá trị 0, false và rỗng là trạng thái khác nhau; thông báo không được bỏ qua khi control đang invalid.
