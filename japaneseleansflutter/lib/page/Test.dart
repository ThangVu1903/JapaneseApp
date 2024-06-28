import 'dart:async';

import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/model/exerciseModel.dart';
import 'package:japaneseleansflutter/page/testResult.dart';
import 'package:japaneseleansflutter/repository/scoreRepository.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../repository/exerciseRepository.dart';

class TestScreen extends StatefulWidget {
  final int lessonNumber;
  final String lessonName;

  List<ExerciseModel> incorrectExercises; //khởi tạo để lưu câu sai

  TestScreen(
      {Key? key,
      required this.lessonNumber,
      List<ExerciseModel>? incorrectExercises,
      required this.lessonName})
      : incorrectExercises = incorrectExercises ?? [],
        super(key: key);

  @override
  _TestScreen createState() => _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  late Future<List<ExerciseModel>> futureExercises;
  List<ExerciseModel>? exercises;
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  int? selectedOption;
  int correctAnswersCount = 0;

  late StreamController<int> _countdownController;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _countdownController = StreamController<int>();
    futureExercises =
        ExerciseRepository().fetchTestExercise(widget.lessonNumber);
    futureExercises.then((exercisesList) {
      setState(() {
        exercises = exercisesList;
        exercises?.shuffle(); // Xáo trộn danh sách các bài tập
      });
      _startCountdown();
    });
  }

  void _startCountdown() {
    // hàm đếm ngược

    if (currentQuestionIndex >= (exercises!.length ?? 0)) {
      return;
    } // Kiểm tra để không chạy đếm ngược nếu không còn câu hỏi
    int countdown =
        exercises![currentQuestionIndex].type == 'vocabulary' ? 3 : 7;
    _countdownTimer?.cancel(); // Hủy Timer cũ nếu có
    _countdownController.add(countdown); // Bắt đầu từ 3
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        countdown--;
        _countdownController.add(countdown);
      } else {
        timer.cancel(); // Hủy Timer khi đếm ngược kết thúc
        if (currentQuestionIndex < (exercises?.length ?? 0) - 1) {
          _nextQuestion();
        } else {
          _showResultScreen(); // Chuyển đến màn hình kết quả nếu đây là câu hỏi cuối cùng
        }
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownController.close();
    super.dispose();
  }

  void _nextQuestion() {
    if (currentQuestionIndex < (exercises?.length ?? 0) - 1) {
      setState(() {
        isAnswered = false;
        selectedOption = null;
        currentQuestionIndex++;
      });
      _startCountdown(); //khởi động lại time khi câu hỏi mới
    } else {
      _showResultScreen(); // Chuyển đến màn hình kết quả nếu đây là câu hỏi cuối cùng
    }
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
    _countdownTimer?.cancel(); // Hủy Timer khi người dùng chọn đáp án
    // Đặt một khoảng thời gian trễ trước khi chuyển sang câu hỏi tiếp theo
    // để người dùng có thời gian nhìn thấy màu của đáp án họ đã chọn.
    Future.delayed(const Duration(milliseconds: 500), () {
      _nextQuestion();
    });
  }

  Future<void> _showResultScreen() async {
    _countdownTimer?.cancel();
    int? userId = Provider.of<User>(context, listen: false)
        .userId; // Sử dụng listen: false nếu bạn chỉ muốn đọc giá trị mà không muốn listen thay đổi
    double score =
        correctAnswersCount / (exercises!.length) * 10.0; // Tính toán điểm số
    print(userId);
    print((widget.lessonNumber + 1));
    print(score);

    try {
      // Gửi điểm số tới server
      await submitScore(userId, (widget.lessonNumber + 1), score);

      // Chuyển đến màn hình kết quả kiểm tra
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TestResult(
            correctAnswers: correctAnswersCount,
            totalQuestions: exercises!.length,
            incorrectExercises: widget.incorrectExercises,
            lessonNumber: widget.lessonNumber,
          ),
        ),
      );
    } catch (e) {
      // Xử lý lỗi nếu việc gửi điểm không thành công
      print(e.toString());
      // Bạn có thể hiển thị thông báo lỗi tới người dùng tại đây
    }
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
          'Hoàn thành hết nha',
          style: TextStyle(color: black),
        ),
        automaticallyImplyLeading: false,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: StreamBuilder<int>(
                            stream: _countdownController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data}',
                                  style: const TextStyle(fontSize: 30),
                                );
                              } else {
                                return const Text(
                                  'Đang chờ...',
                                  style: TextStyle(fontSize: 20),
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
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
                        ),
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
