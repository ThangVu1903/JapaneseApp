import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../repository/vocabularyReprsitory.dart';

class AddVocabularyScreen extends StatefulWidget {
  late int lessonNumber;

  AddVocabularyScreen({required this.lessonNumber, super.key});
  @override
  _AddVocabularyScreenState createState() => _AddVocabularyScreenState();
}

class _AddVocabularyScreenState extends State<AddVocabularyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hiraganaController = TextEditingController();
  final TextEditingController _kanjiController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();
  final TextEditingController _exampleController = TextEditingController();
  final TextEditingController _exampleMeaningController =
      TextEditingController();

  final VocabularyRepository _vocabularyRepository =
      VocabularyRepository(); // Tạo instance của repository

  void _addVocabulary() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _vocabularyRepository.addVocabulary(
          widget.lessonNumber + 1,
          _hiraganaController.text,
          _kanjiController.text.isNotEmpty ? _kanjiController.text : null,
          _meaningController.text,
          _exampleController.text.isNotEmpty ? _exampleController.text : null,
          _exampleMeaningController.text.isNotEmpty
              ? _exampleMeaningController.text
              : null,
        );
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: white_1,
          gravity: ToastGravity.TOP,
          msg: "Thêm câu hỏi thành công!",
        );

        _formKey.currentState!.reset();
        _hiraganaController.clear();
        _kanjiController.clear();
        _meaningController.clear();
        _exampleController.clear();
        _exampleMeaningController.clear();
        // Xử lý thành công (ví dụ: hiển thị thông báo, reset form, ...)
      } catch (e) {
        // Xử lý lỗi
        print('Lỗi khi thêm từ vựng: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm từ vựng'),
       
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
                TextFormField(
                  controller: _hiraganaController,
                  decoration: const InputDecoration(labelText: 'Hiragana'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập Hiragana';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kanjiController,
                  decoration:
                      const InputDecoration(labelText: 'Kanji (tùy chọn)'),
                ),
                TextFormField(
                  controller: _meaningController,
                  decoration: const InputDecoration(labelText: 'Nghĩa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nghĩa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _exampleController,
                  decoration:
                      const InputDecoration(labelText: 'Ví dụ (tùy chọn)'),
                ),
                TextFormField(
                  controller: _exampleMeaningController,
                  decoration: const InputDecoration(
                      labelText: 'Nghĩa của ví dụ (tùy chọn)'),
                ),
                // DropdownButtonFormField để chọn bài học (bạn cần lấy dữ liệu bài học từ API hoặc nguồn khác)

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: _addVocabulary,
                    child: const Text('Thêm từ vựng'),
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
