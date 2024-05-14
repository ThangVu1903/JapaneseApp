import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                  'Nhập email ...',
                  const Icon(
                    Icons.email,
                    color: Color.fromRGBO(18, 84, 132, 0.612),
                  )),
              inputText(
                'Nhập mật khẩu',
                const Icon(
                  Icons.key,
                  color: Color.fromRGBO(16, 75, 118, 0.612),
                ),
              ),
              inputText(
                'Nhập lại mật khẩu',
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
                      backgroundColor: const Color.fromRGBO(16, 75, 118, 0.612),
                    ),
                    onPressed: () {},
                    child: const SizedBox(
                      height: 55,
                      width: 340,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tạo',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  inputText(String lable, Widget icon) {
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
}
