import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../model/exerciseModel.dart';

class TestResult extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List<ExerciseModel>? incorrectExercises;
  final int lessonNumber;

  const TestResult({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    this.incorrectExercises,
    required this.lessonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String scoreT = (correctAnswers / totalQuestions * 10).toStringAsFixed(2);
    double score = double.parse(scoreT);
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hoàn thành !',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Bạn được: $score điểm ($correctAnswers / $totalQuestions)',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                score > 8
                    ? "Bạn làm xuất sắc quá !"
                    : score > 6
                        ? "Bạn làm rất tốt"
                        : 'Lần sau cố gắng thêm một chút nhé !',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
