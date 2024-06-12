import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/model/exerciseModel.dart';
import '../page/resultExerciseScreen.dart';
import '../repository/exerciseRepository.dart';

class ExerciseScreen extends StatefulWidget {
  final int lessonNumber;
  final String type;
  List<ExerciseModel> incorrectExercises; //khởi tạo để lưu câu sai

  ExerciseScreen(
      {Key? key,
      required this.lessonNumber,
      required this.type,
      List<ExerciseModel>? incorrectExercises})
      : incorrectExercises = incorrectExercises ?? [],
        super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late Future<List<ExerciseModel>> futureExercises;
  List<ExerciseModel>? exercises;
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  int? selectedOption;
  int correctAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    futureExercises =
        ExerciseRepository().fetchExercise(widget.lessonNumber, widget.type);
    futureExercises.then((exercisesList) {
      setState(() {
        exercises = exercisesList;
      });
    });
  }

  void _nextQuestion() {
    setState(() {
      isAnswered = false;
      selectedOption = null;
      if (currentQuestionIndex < (exercises?.length ?? 0) - 1) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = 0;
      }
    });
  }

  void _checkAnswer(int selectedOption) {
    if (exercises![currentQuestionIndex].correctOption == selectedOption) {
      correctAnswersCount++;
    } else {
      widget.incorrectExercises.add(exercises![currentQuestionIndex]);
    }
    setState(() {
      isAnswered = true;
      this.selectedOption = selectedOption;
    });

    // Đặt một khoảng thời gian trễ trước khi chuyển sang câu hỏi tiếp theo
    // để người dùng có thời gian nhìn thấy màu của đáp án họ đã chọn.
    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < (exercises?.length ?? 0) - 1) {
        _nextQuestion();
      } else {
        _showResultScreen();
      }
    });
  }

  void _showResultScreen() {
    //màn hình kết quả luyện tập
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultExerciseScreen(
                  correctAnswers: correctAnswersCount,
                  totalQuestions: exercises!.length,
                  incorrectExercises: widget.incorrectExercises,
                  lessonNumber: widget.lessonNumber,
                  type: widget.type,
                )));
  }

  Color _getOptionColor(int optionNumber) {
    if (!isAnswered) {
      return yellow_1; // Màu cho đáp án chưa được chọn
    }
    if (optionNumber == selectedOption) {
      return optionNumber == exercises![currentQuestionIndex].correctOption
          ? Colors.green // Màu cho đáp án đúng
          : Colors.red; // Màu cho đáp án sai
    }
    // Màu cho các đáp án khác sau khi đã chọn đáp án
    return yellow_1;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow_1,
        title: const Text(
          'Luyện tập',
          style: TextStyle(color: black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ExerciseModel>>(
        future: futureExercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises available'));
          } else {
            ExerciseModel currentExercise = exercises![currentQuestionIndex];
            return Container(
              color: white_2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 1 / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              '${currentExercise.questionNumber}/${exercises?.length}',
                              style: const TextStyle(fontSize: 20)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: SizedBox(
                              width: size.width,
                              child: Column(
                                children: [
                                  Text(
                                    currentExercise.questionContent,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  if (currentExercise.kanjiQuestion != null)
                                    Text(
                                      currentExercise.kanjiQuestion!,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  btnAnswered(
                      Text(
                        currentExercise.option1,
                        style: const TextStyle(color: black, fontSize: 20),
                      ),
                      1,
                      size),
                  btnAnswered(
                      Text(
                        currentExercise.option2,
                        style: const TextStyle(color: black, fontSize: 20),
                      ),
                      2,
                      size),
                  btnAnswered(
                      Text(
                        currentExercise.option3,
                        style: const TextStyle(color: black, fontSize: 20),
                      ),
                      3,
                      size),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget btnAnswered(Widget text, int index, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: !isAnswered ? () => _checkAnswer(index) : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return _getOptionColor(index);
          }),
        ),
        child: SizedBox(
            width: size.width,
            height: size.height * 1 / 11,
            child: Center(child: text)),
      ),
    );
  }
}
