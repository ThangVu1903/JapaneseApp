import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/page/Test.dart';
import 'package:japaneseleansflutter/page/testRank.dart';

import '../constants/colors.dart';

class TestLesson extends StatelessWidget {
  final String lessonName;
  final int lessonNumber;
  const TestLesson(
      {super.key, required this.lessonName, required this.lessonNumber});

  handleTest(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Làm kiểm tra ?',
            ),
            content: const Text(
              'Khi bắt đầu bạn sẽ không được dừng lại và hoàn thành hết',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Hủy',
                  style: TextStyle(fontWeight: FontWeight.bold, color: black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Bắt đầu',
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TestScreen(
                          lessonNumber: lessonNumber,
                          lessonName: lessonName,
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  handleRank(context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return  TestRanK(
            lessonNumber: lessonNumber,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

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
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: white_2,
                width: size.width,
                height: size.height * 1 / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleTest(context);
                      },
                      child: Container(
                        //flashcar

                        width: size.width * 2 / 5,
                        height: size.height * 1 / 5 * 4 / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: yellow_2,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 40,
                                  offset: Offset(8, 20))
                            ]),
                        child: Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset('asset/icons/testing.png')),
                            const Text(
                              "Kiểm tra",
                              style: TextStyle(
                                  color: white_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      //flashcar Text

                      width: size.width * 2 / 5,
                      height: size.height * 1 / 5 * 4 / 5,
                      child: const Column(
                        children: [
                          Text("Làm kiểm tra nào ! ",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                          Text(
                              "Đây là bài kiểm tra trắc nghiệm, hãy chọn nhanh nhé !",
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: white_2,
                width: size.width,
                height: size.height * 1 / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleRank(context);
                      },
                      child: Container(
                        width: size.width * 2 / 5,
                        height: size.height * 1 / 5 * 4 / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: yellow_2,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 40,
                                  offset: Offset(8, 20))
                            ]),
                        child: Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset('asset/icons/user.png')),
                            const Text(
                              "Xếp hạng",
                              style: TextStyle(
                                  color: white_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      //flashcar Text

                      width: size.width * 2 / 5,
                      height: size.height * 1 / 5,
                      child: const Column(
                        children: [
                          Text("Bảng xếp hạng người dùng ! ",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                          Text("Cùng xem bạn đứng thứ bao nhiêu nhé ! ",
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
