import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/page/home.dart';
import 'package:japaneseleansflutter/page/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  late bool _showpassword = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Ẩn bàn phím khi nhấn bất kỳ nơi nào bên ngoài vùng TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            color: yellow_1,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset('asset/images/logo.png')),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    "ĐĂNG NHẬP",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              blurRadius: 2.0,
                              color: Colors.grey,
                              offset: Offset(2, 2))
                        ]),
                  ),
                ),
                inputText(
                  _emailController,
                  'Email...',
                  const Icon(
                    Icons.email,
                    color: Color.fromRGBO(18, 84, 132, 0.612),
                  ),
                ),
                inputText(
                    _passController,
                    'Mật khẩu...',
                    const Icon(
                      Icons.key,
                      color: Color.fromRGBO(16, 75, 118, 0.612),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _showpassword = !_showpassword;
                          });
                        },
                        icon: _showpassword
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.visibility_off),
                        color: const Color.fromRGBO(16, 75, 118, 0.612)),
                    _showpassword),
                InkWell(
                  child: const Text(
                    'Quên mật khẩu ?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signup()));
                  },
                ),
                Padding(
                  //button login
                  padding: const EdgeInsets.only(
                      top: 50, left: 40, right: 40, bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(16, 75, 118, 0.612),
                      ),
                      onPressed: onSignInclicked,
                      child: const SizedBox(
                        height: 55,
                        width: 340,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đăng nhập ',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    child: const Text(
                      'Tạo tài khoản ?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Color.fromARGB(255, 35, 31, 254)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const signup()));
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "asset/icons/google.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Text(
                        "Đăng nhập với Google",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  inputText(TextEditingController controller, String lable, Widget icon,
      [Widget? eye, bool obscureTexts = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Material(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        elevation: 18,
        shadowColor: Colors.grey,
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.none,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(156, 232, 232, 232),
              prefixIcon: icon,
              suffixIcon: eye,
              border: const UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              label: Text(lable),
              labelStyle: const TextStyle(color: Colors.grey)),
          obscureText: obscureTexts,
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Sử dụng regular expression để kiểm tra định dạng email
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Kiểm tra độ dài mật khẩu, thêm các kiểm tra khác nếu cần
    return password.length >= 4;
  }

  Future<void> onSignInclicked() async {
    FocusScope.of(context).unfocus();

    if (!isValidEmail(_emailController.text)) {
      showErrorMessage("Địa chỉ email không hợp lệ.");
      return;
    }

    if (!isValidPassword(_passController.text)) {
      showErrorMessage("Mật khẩu không hợp lệ. Phải có ít nhất 4 ký tự.");
      return;
    }
    showLoadingSpinner();

    try {
      const String apiUrl = 'http://192.168.1.213:8088/auth/login';

      final Map<String, String> body = {
        'email': _emailController.text,
        'password': _passController.text,
      };

      Dio dio = Dio();
      final response = await dio.post(apiUrl, data: body);
      hideLoadingSpinner();
      // Xử lý phản hồi từ API
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData['token'] != null) {
          // Lấy token và refreshToken từ responseData, nếu có
          // final String token = responseData['token'];
          // final String refreshToken = responseData['refreshToken'];

          showSuccessSnackBar('Đăng nhập thành công');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Home()),
          );
        } else {
          // Xử lý trường hợp dữ liệu trả về null hoặc không có token
          showErrorMessage(
              "Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin đăng nhập.");
        }
      } else {
        // Đăng nhập thất bại, hiển thị thông báo lỗi
        final String message = response.data['message'] ??
            'Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin đăng nhập.';
        showErrorMessage(message);
      }
    } catch (e) {
      // Xử lý lỗi kết nối hoặc lỗi không xác định
      print("Đã xảy ra lỗi: $e");
      showErrorMessage("Đã xảy ra lỗi. Vui lòng thử lại sau.");
    }
  }

  void showLoadingSpinner() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Ngăn người dùng đóng dialog bằng cách nhấp bên ngoài
      builder: (BuildContext context) {
        return const Center(
          child:
              CircularProgressIndicator(), // Hiển thị tiến trình quay (spinner)
        );
      },
    );
  }

  void hideLoadingSpinner() {
    Navigator.of(context).pop(); // Ẩn dialog tiến trình quay (spinner)
  }

  void showSuccessSnackBar(String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: white_1,
      // Màu nền xanh cho SnackBar thành công
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lỗi !"),
          content: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }
}
