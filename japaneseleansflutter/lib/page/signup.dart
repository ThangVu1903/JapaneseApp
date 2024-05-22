import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../repository/signupRepository.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final SignupRepository signupRepository = SignupRepository();

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
                    padding: const EdgeInsets.only(top: 90),
                    child: Image.asset('asset/images/logo.png')),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    "ĐĂNG KÝ",
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
                    emailController,
                    'Nhập email ...',
                    const Icon(
                      Icons.email,
                      color: Color.fromRGBO(18, 84, 132, 0.612),
                    )),
                inputText(
                    usernameController,
                    'Nhập tên...',
                    const Icon(
                      Icons.email,
                      color: Color.fromRGBO(18, 84, 132, 0.612),
                    )),
                inputText(
                  passController,
                  'Nhập mật khẩu...',
                  const Icon(
                    Icons.key,
                    color: Color.fromRGBO(16, 75, 118, 0.612),
                  ),
                ),
                Padding(
                  //button login
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(16, 75, 118, 0.612),
                      ),
                      onPressed: () {
                        signUp();
                      },
                      child: const SizedBox(
                        height: 55,
                        width: 340,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tạo',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: white_2),
                              ),
                            ]),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  inputText(TextEditingController controller, String lable, Widget icon) {
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
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(156, 232, 232, 232),
              prefixIcon: icon,
              border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )),
              label: Text(lable),
              labelStyle: const TextStyle(color: Colors.grey)),
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

  void signUp() {
    FocusScope.of(context).unfocus();
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passController.text;

    if (!isValidEmail(email)) {
      Fluttertoast.showToast(
        msg: "Email không hợp lệ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (!isValidPassword(password)) {
      Fluttertoast.showToast(
        msg: "Mật khẩu không hợp lệ, phải có ít nhất 6 kí tự",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    signupRepository.signUp(email, username, password, context);
  }
}
