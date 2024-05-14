import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CourseComponent_N4 extends StatelessWidget {
  const CourseComponent_N4({
    super.key,
    required this.size,
    required this.onPressed,
  });

  final Size size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 30),
      width: size.width * 3 / 4,
      height: size.height * 1 / 3,
      decoration: BoxDecoration(
        color: white_2, // Màu nền của Container
        border: Border.all(
          color: Colors.black, // Màu viền
          width: 2, // Độ dày của viền
        ),
        borderRadius: BorderRadius.circular(20), // Độ cong của viền
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0)
                .withOpacity(0.5), // Màu shadow và độ mờ
            spreadRadius: 5, // Bán kính của shadow
            blurRadius: 7, // Độ mờ của shadow
            offset: const Offset(0, 5), // Độ lệch của shadow theo trục x, y
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'N4',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                '(Sơ cấp)',
                style: TextStyle(),
              ),
            ]),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Thông tin",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0), // Khoảng cách giữa các text
                const Text(
                  "Học từ bài 26 đến 50 (từ vựng, ngữ pháp, luyện tập, kiểm tra...)",
                  softWrap: true,
                  style: TextStyle(fontSize: 12),
                  // Cho phép văn bản tự động xuống dòng khi không đủ không gian
                ),
                const SizedBox(height: 8.0), // Khoảng cách giữa các text
                const Text(
                  "Sau khi học tất cả mọi thứ, bạn sẽ lắm được kiến thức cơ bản ở trình độ N4",
                  softWrap: true,
                  style: TextStyle(fontSize: 12),
                ),
                const Text(
                  "Ngôn ngữ : Tiếng Việt",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 4.0,
                      backgroundColor: yellow_2),
                  child: const Text(
                    "Bắt đầu ngay",
                    style: TextStyle(color: white_1),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
