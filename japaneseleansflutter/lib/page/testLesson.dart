import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TestLesson extends StatelessWidget {
  const TestLesson({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: white_2,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [yellow_1, yellow_2],
              ),
            ),
            width: size.width,
            height: 50,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    "Kiểm tra",
                    style: TextStyle(
                      fontSize: 20, // Đặt kích thước chữ là 24
                      fontWeight: FontWeight.bold, // Đặt đậm
                      color: Colors.white, // Đặt màu trắng
                      fontFamily: 'Roboto', // Đặt font chữ
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
