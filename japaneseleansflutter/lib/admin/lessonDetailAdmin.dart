import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/admin/grammarAdmin.dart';
import 'package:japaneseleansflutter/admin/testAdmin.dart';
import 'package:japaneseleansflutter/admin/vocabularyAdmin.dart';

class LessonDetailAdmin extends StatelessWidget {
  int lessonNumber;
  String lessonName;

  LessonDetailAdmin(
      {required this.lessonNumber, required this.lessonName, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Bài $lessonNumber : $lessonName'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.text_format), text: 'Từ Vựng'),
                Tab(icon: Icon(Icons.star), text: 'Ngữ Pháp'),
                Tab(
                    icon: Icon(Icons.align_vertical_bottom_outlined),
                    text: 'Kiểm Tra'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              VocabularyAdmin(
                lessonNumber: lessonNumber,
              ),
              GrammarAdmin(lessonNumber: lessonNumber),
              TestAdmin(lessonNumber: lessonNumber),
            ],
          )),
    );
  }
}
