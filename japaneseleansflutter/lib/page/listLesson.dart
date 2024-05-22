import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/page/detailLesson.dart';
import 'package:japaneseleansflutter/repository/lessonRepository.dart';
import '../model/Lesson.dart';

class LessonList extends StatelessWidget {
  final String courseName;
  final LessonRepository lessonRepository;

  const LessonList(
      {super.key, required this.courseName, required this.lessonRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_2,
      appBar: AppBar(
        backgroundColor: yellow_1,
        title: Text(
          "Cấp độ $courseName",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder<List<Lesson>>(
            future: lessonRepository.fetchLessons(courseName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Lesson>? lessons = snapshot.data;
                return ListView.builder(
                    itemCount: lessons!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: yellow_2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 15,
                        child: ListTile(
                          title: Row(
                            children: [
                              Image.asset("asset/icons/learning.png"),
                              Text(
                                '    Bài ${lessons[index].lesson_number}: ${lessons[index].lesson_name}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return DetailLesson(
                                    lessonName: lessons[index].lesson_name,
                                    lessonNumber: lessons[index].lesson_number,
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                      );
                    });
              }
            }),
      ),
    );
  }
}
