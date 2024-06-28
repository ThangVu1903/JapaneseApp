import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../model/vocabularyModel.dart';
import '../repository/vocabularyReprsitory.dart';

class EditVocabularyScreen extends StatefulWidget {
  final VocabularyModel
      vocabulary; // Nhận đối tượng VocabularyModel từ bên ngoài
  int lessonNumber;

  EditVocabularyScreen(
      {required this.vocabulary, required this.lessonNumber, super.key});

  @override
  _EditVocabularyScreenState createState() => _EditVocabularyScreenState();
}

class _EditVocabularyScreenState extends State<EditVocabularyScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _hiraganaController;
  late TextEditingController _kanjiController;
  late TextEditingController _meaningController;
  late TextEditingController _exampleController;
  late TextEditingController _exampleMeaningController;

  final VocabularyRepository _vocabularyRepository = VocabularyRepository();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với giá trị từ VocabularyModel
    _hiraganaController =
        TextEditingController(text: widget.vocabulary.hiragana);
    _kanjiController = TextEditingController(text: widget.vocabulary.kanji);
    _meaningController =
        TextEditingController(text: widget.vocabulary.meanning);
    _exampleController = TextEditingController(text: widget.vocabulary.example);
    _exampleMeaningController =
        TextEditingController(text: widget.vocabulary.example_meanning);
  }

  void _updateVocabulary() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _vocabularyRepository.updateVocabulary(
          widget.vocabulary.vocabulary_id,
          widget.lessonNumber,
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
          msg: "Cập nhật câu hỏi thành công!",
        );
        Navigator.pop(
            context); // Trở về màn hình trước sau khi cập nhật thành công
        // Xử lý thành công (ví dụ: hiển thị thông báo, reset form, ...)
      } catch (e) {
        // Xử lý lỗi
        print('Lỗi khi cập nhật từ vựng: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa từ vựng'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: _updateVocabulary,
                    child: const Text('Cập nhật từ vựng'),
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
