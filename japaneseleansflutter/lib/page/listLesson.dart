import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: FutureBuilder<List<Lesson>>(
          future: lessonRepository.fetchLessons(courseName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Lesson>? lessons = snapshot.data;
              return ListView.builder(
                  itemCount: lessons!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Bài ${lessons[index].lesson_number}: ${lessons[index].lesson_name}'),
                    );
                  });
            }
          }),
    );
  }
}
