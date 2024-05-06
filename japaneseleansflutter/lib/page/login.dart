import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/page/home.dart';
import 'package:japaneseleansflutter/page/signup.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
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
            color: const Color.fromARGB(156, 255, 200, 91),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Image.asset('asset/images/logo.png')),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    "LOGIN",
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
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "asset/icons/google.png",
                          )),
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

  Future<void> onSignInclicked() async {
    FocusScope.of(context).unfocus();
    //Kiểm tra tính hợp lệ của địa chỉ email và mật khẩu
    // if (_emailController.text.isEmpty ||
    //     _emailController.text.contains("@") ||
    //     _passController.text.isEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text("Lỗi !"),
    //           content:
    //               const Text("Vui lòng nhập địa chỉ email và mật khẩu hợp lệ "),
    //           actions: <Widget>[
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text("Đóng"))
    //           ],
    //         );
    //       });
    //   return;
    // }

    // Tạo dữ liệu
    const String apiUrl = 'http://localhost:8088/auth/login';
    // final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {
      'email': _emailController.text,
      'password': _passController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      // headers: headers,
      body: body,
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    // Xử lý phản hồi từ API
    if (response.statusCode == 200) {
      //đăng nhập thành công
      //lưu token vào bộ nhớ cục bộ và chuyển hướng
      // var jsonResponse = jsonDecode(response.body);
      // var token = jsonResponse['token'];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', token);
      final String token = responseData['token'];
      final String refreshToken = responseData['refreshToken'];

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } else {
      // Đăng nhập thất bại
      final String message = responseData['message'];
      // Hiển thị thông báo lỗi cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng nhập không thành công: $message'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lỗi !"),
          content: Text(message),
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
