import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/admin/addTest.dart';
import 'package:japaneseleansflutter/admin/editTest.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/repository/exerciseRepository.dart';

import '../model/exerciseModel.dart';

class TestAdmin extends StatefulWidget {
  final int lessonNumber;

  const TestAdmin({required this.lessonNumber, Key? key}) : super(key: key);

  @override
  State<TestAdmin> createState() => _TestAdminState();
}

class _TestAdminState extends State<TestAdmin> {
  final ExerciseRepository exerciseRepository = ExerciseRepository();
  late Future<List<ExerciseModel>> _futureExercises;

  @override
  void initState() {
    super.initState();
    _loadExercises(); // Gọi hàm để tải dữ liệu ban đầu
  }

  Future<void> _loadExercises() async {
    setState(() {
      _futureExercises =
          exerciseRepository.fetchTestExercise(widget.lessonNumber);
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ExerciseModel exercise) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa bài tập này không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                try {
                  await exerciseRepository.deleteExercise(exercise.exerciseId);
                  Navigator.of(context).pop();
                  _loadExercises(); // Gọi lại hàm để tải lại danh sách
                  Fluttertoast.showToast(
                    backgroundColor: Colors.green,
                    textColor: white_1,
                    gravity: ToastGravity.TOP,
                    msg: "Xoá thành công!",
                  );
                } catch (e) {
                  print('Lỗi khi xóa bài tập: $e');
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: white_1,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTest(
                  lessonNumber: widget.lessonNumber,
                ),
              ),
            ).then((value) {
              if (value != null && value) {
                // Kiểm tra xem bài tập có được thêm thành công không
                _loadExercises(); // Reload lại danh sách nếu có
              }
            });
          },
          child: const Icon(Icons.add)),
      body: FutureBuilder<List<ExerciseModel>>(
        future: exerciseRepository.fetchTestExercise(widget.lessonNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var exercise = snapshot.data![index];
                return Card(
                  color: yellow_1,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Câu ${index + 1}. Thể loại: ${exercise.type}"),
                            Row(
                              children: [
                                Text(
                                  "Câu hỏi:${exercise.questionContent} ",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(exercise.questionNumber == "null"
                                    ? " "
                                    : "(${exercise.kanjiQuestion}) "),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '1 .${exercise.option1}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '2 .${exercise.option2}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '3 .${exercise.option3}',
                              ),
                            ),
                            Text('Đáp án đúng: ${exercise.correctOption}'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTestScreen(
                                      lessonNumber: widget.lessonNumber,
                                      exercise: exercise,
                                    ),
                                  ),
                                ).then((value) => _loadExercises());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmationDialog(
                                    context, exercise);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
