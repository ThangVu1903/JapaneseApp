import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../repository/exerciseRepository.dart';

class AddTest extends StatefulWidget {
  final int lessonNumber; // Truyền vào số bài học

  const AddTest({required this.lessonNumber, Key? key}) : super(key: key);

  @override
  _AddTest createState() => _AddTest();
}

class _AddTest extends State<AddTest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _questionNumberController =
      TextEditingController();
  final TextEditingController _kanjiQuestionController =
      TextEditingController();
  final TextEditingController _questionContentController =
      TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _correctOptionController =
      TextEditingController();

  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  void _addExercise() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _exerciseRepository.addExercise(
          widget.lessonNumber + 1,
          _typeController.text,
          int.parse(_questionNumberController.text),
          _kanjiQuestionController.text,
          _questionContentController.text,
          _option1Controller.text,
          _option2Controller.text,
          _option3Controller.text,
          int.parse(_correctOptionController.text),
        );

        Fluttertoast.showToast(
          msg: "Thêm câu hỏi kiểm tra thành công!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pop(
            context, true); // Trả về true để báo hiệu đã thêm bài tập mới
      } catch (e) {
        print('Lỗi khi thêm bài tập: $e');
        Fluttertoast.showToast(
          msg: "Lỗi: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm câu hỏi kiểm tra bài ${widget.lessonNumber}'),
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
                    onPressed: _addExercise,
                    child: const Text('Thêm bài tập'),
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
