import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../repository/grammarRepository.dart';

class AddGrammarScreen extends StatefulWidget {
  final int lessonNumber;

  const AddGrammarScreen({required this.lessonNumber, Key? key})
      : super(key: key);

  @override
  _AddGrammarScreenState createState() => _AddGrammarScreenState();
}

class _AddGrammarScreenState extends State<AddGrammarScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _structureController = TextEditingController();
  final TextEditingController _explainGrammarController =
      TextEditingController();
  final TextEditingController _exampleController = TextEditingController();
  final TextEditingController _exampleMeaningController =
      TextEditingController();

  final GrammarRepository _grammarRepository = GrammarRepository();

  void _addGrammar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _grammarRepository.addGrammar(
          widget.lessonNumber + 1,
          _structureController.text,
          _explainGrammarController.text,
          _exampleController.text,
          _exampleMeaningController.text,
        );
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: white_1,
          gravity: ToastGravity.TOP,
          msg: "Thêm ngữ pháp thành công!",
        );

        // Reset form sau khi thêm thành công
        _formKey.currentState!.reset();
        _structureController.clear();
        _explainGrammarController.clear();
        _exampleController.clear();
        _exampleMeaningController.clear();

        Navigator.pop(
            context, true); // Trả về true để báo hiệu đã thêm ngữ pháp mới
      } catch (e) {
        print('Lỗi khi thêm ngữ pháp: $e');
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: white_1,
          gravity: ToastGravity.TOP,
          msg: "Lỗi: $e",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm ngữ pháp'),
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
                  controller: _structureController,
                  decoration: const InputDecoration(labelText: 'Cấu trúc'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập cấu trúc ngữ pháp';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _explainGrammarController,
                  decoration: const InputDecoration(labelText: 'Giải thích'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giải thích ngữ pháp';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                TextFormField(
                  controller: _exampleController,
                  decoration: const InputDecoration(labelText: 'Ví dụ '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng ví dụ cho ngữ pháp';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _exampleMeaningController,
                  decoration:
                      const InputDecoration(labelText: 'Nghĩa của ví dụ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nghĩa ví dụ';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: _addGrammar,
                    child: const Text('Thêm ngữ pháp'),
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
