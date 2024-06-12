import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../component/exercise.dart';
import '../model/exerciseModel.dart';

class ResultExerciseScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List<ExerciseModel>? incorrectExercises;
  final int lessonNumber;
  final String type;

  const ResultExerciseScreen({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    this.incorrectExercises,
    required this.lessonNumber,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow_1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Kết Quả'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bạn đã làm đúng $correctAnswers / $totalQuestions câu',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    lessonNumber:
                        lessonNumber, // Giả sử bạn đã lưu giữ lessonNumber
                    type: type, // Giả sử bạn đã lưu giữ type
                  ),
                ));
              },
              child: const Text('Làm Lại Tất Cả'),
            ),
          ],
        ),
      ),
    );
  }
}
