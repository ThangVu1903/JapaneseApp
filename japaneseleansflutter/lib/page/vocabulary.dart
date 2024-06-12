import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/component/exercise.dart';
import 'package:japaneseleansflutter/component/listVocabulary.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/component/flascard.dart';

class Vocabulary extends StatelessWidget {
  final String lessonName;
  final int lessonNumber;
  const Vocabulary(
      {super.key, required this.lessonName, required this.lessonNumber});

  handleFlashcar(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FlashcardScreen(
            lessonName: lessonName,
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

  handleListVocab(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ListVocabulary(
            lessonName: lessonName,
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

  handleExercise(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ExerciseScreen(
            type: "vocabulary",
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
                    "Từ vựng",
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
                    handleFlashcar(context);
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('asset/icons/flash-cards.png')),
                        const Text(
                          "Flashcard",
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
                      Text("Hãy học phần này đầu tiên ! ",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      Text("Nhớ đọc cả ví dụ để hiểu bối cảnh nhaaa ",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: size.width,
            height: size.height * 1 / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  //danh sách từ vựng

                  width: size.width * 2 / 5,
                  height: size.height * 1 / 5 * 4 / 5,
                  child: const Column(
                    children: [
                      Text("Xem lại một lần nữa ! ",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      Text("Nhìn tổng quan các từ đã học nào ",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleListVocab(context);
                  },
                  child: Container(
                    //list
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: yellow_2,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(8, 20))
                        ]),
                    width: size.width * 2 / 5,
                    height: size.height * 1 / 5 * 4 / 5,
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('asset/icons/list.png')),
                        const Text(
                          "Danh sách từ",
                          style: TextStyle(
                              color: white_1,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
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
                    handleExercise(context);
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('asset/icons/planning.png')),
                        const Text(
                          "Luyện tập",
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
                      Text("Luyện tập nào ! ",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      Text("Nhớ hoàn thành khi có thông báo nhé ! ",
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
    );
  }
}
