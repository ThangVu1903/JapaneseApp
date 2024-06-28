import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/exerciseModel.dart';
import '../repository/exerciseRepository.dart';

class EditTestScreen extends StatefulWidget {
  final ExerciseModel exercise;
  final int lessonNumber;

  const EditTestScreen(
      {Key? key, required this.exercise, required this.lessonNumber})
      : super(key: key);

  @override
  _EditTestScreen createState() => _EditTestScreen();
}

class _EditTestScreen extends State<EditTestScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _questionNumberController;
  late TextEditingController _kanjiQuestionController;
  late TextEditingController _questionContentController;
  late TextEditingController _option1Controller;
  late TextEditingController _option2Controller;
  late TextEditingController _option3Controller;
  late TextEditingController _correctOptionController;

  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với giá trị từ exercise
    _typeController = TextEditingController(text: widget.exercise.type);
    _questionNumberController =
        TextEditingController(text: widget.exercise.questionNumber.toString());
    _kanjiQuestionController =
        TextEditingController(text: widget.exercise.kanjiQuestion ?? '');
    _questionContentController =
        TextEditingController(text: widget.exercise.questionContent);
    _option1Controller = TextEditingController(text: widget.exercise.option1);
    _option2Controller = TextEditingController(text: widget.exercise.option2);
    _option3Controller = TextEditingController(text: widget.exercise.option3);
    _correctOptionController =
        TextEditingController(text: widget.exercise.correctOption.toString());
  }

  @override
  void dispose() {
    // Giải phóng các controller khi widget bị hủy
    _typeController.dispose();
    _questionNumberController.dispose();
    _kanjiQuestionController.dispose();
    _questionContentController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _correctOptionController.dispose();
    super.dispose();
  }

  void _updateExercise() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _exerciseRepository.updateExercise(
          widget.exercise.exerciseId,
          widget.lessonNumber,
          _typeController.text,
          int.parse(_questionNumberController.text),
          _kanjiQuestionController.text.isNotEmpty
              ? _kanjiQuestionController.text
              : null,
          _questionContentController.text,
          _option1Controller.text,
          _option2Controller.text,
          _option3Controller.text,
          int.parse(_correctOptionController.text),
        );
        Fluttertoast.showToast(
          msg: "Cập nhật bài tập thành công!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // thông báo cho màn hình trước cập nhật dữ liệu
        Navigator.of(context).pop(true);
      } catch (e) {
        print('Lỗi khi cập nhật bài tập: $e');
        // Hiển thị thông báo lỗi chi tiết hơn
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa câu hỏi kiểm tra bài ${widget.exercise.lessonId-1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: _typeController.text.isNotEmpty
                      ? _typeController.text
                      : null,
                  decoration: const InputDecoration(
                      labelText: 'Câu hỏi thuộc ngữ pháp hay từ vựng'),
                  items: ['vocabulary', 'grammar'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _typeController.text = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng chọn loại câu hỏi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _questionNumberController,
                  decoration: const InputDecoration(
                      labelText: 'Thứ tự câu hỏi trong bài kiểm tra'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập thứ tự câu hỏi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _questionContentController,
                  decoration:
                      const InputDecoration(labelText: 'Nội dung câu hỏi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nội dung câu hỏi';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                TextFormField(
                  controller: _kanjiQuestionController,
                  decoration: const InputDecoration(
                      labelText: 'Kanji cho câu hỏi trên (nếu có)'),
                ),
                TextFormField(
                  controller: _option1Controller,
                  decoration: const InputDecoration(labelText: 'Lựa chọn 1'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lựa chọn 1';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _option2Controller,
                  decoration: const InputDecoration(labelText: 'Lựa chọn 2'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lựa chọn 2';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _option3Controller,
                  decoration: const InputDecoration(labelText: 'Lựa chọn 3'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lựa chọn 3';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _correctOptionController,
                  decoration: const InputDecoration(
                      labelText: 'Đáp án đúng (1, 2, hoặc 3)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập đáp án đúng';
                    }
                    final option = int.tryParse(value);
                    if (option == null || option < 1 || option > 3) {
                      return 'Đáp án đúng phải là 1, 2, hoặc 3';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: _updateExercise,
                    child: const Text('Cập nhật câu hỏi'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
