import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../model/grammarModel.dart';
import '../repository/grammarRepository.dart';

class EditGrammarScreen extends StatefulWidget {
  final GrammarModel grammar;
  final int lessonNumber; // Nhận đối tượng GrammarModel từ bên ngoài

  const EditGrammarScreen(
      {required this.grammar, Key? key, required this.lessonNumber})
      : super(key: key);

  @override
  _EditGrammarScreenState createState() => _EditGrammarScreenState();
}

class _EditGrammarScreenState extends State<EditGrammarScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _structureController;
  late TextEditingController _explainGrammarController;
  late TextEditingController _exampleController;
  late TextEditingController _exampleMeaningController;

  final GrammarRepository _grammarRepository = GrammarRepository();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với giá trị từ GrammarModel
    _structureController =
        TextEditingController(text: widget.grammar.structure);
    _explainGrammarController =
        TextEditingController(text: widget.grammar.explain_grammar ?? '');
    _exampleController =
        TextEditingController(text: widget.grammar.example ?? '');
    _exampleMeaningController =
        TextEditingController(text: widget.grammar.example_meanning ?? '');
  }

  void _updateGrammar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _grammarRepository.updateGrammar(
          widget.grammar.grammar_id,
          widget.lessonNumber,
          _structureController.text,
          _explainGrammarController.text,
          _exampleController.text,
          _exampleMeaningController.text,
        );
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: white_1,
          gravity: ToastGravity.TOP,
          msg: "Cập nhật ngữ pháp thành công!",
        );

        Navigator.pop(
            context, true); // Trả về true để báo hiệu đã cập nhật ngữ pháp
      } catch (e) {
        print('Lỗi khi cập nhật ngữ pháp: $e');
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
        title: const Text('Sửa ngữ pháp'),
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
                  decoration:
                      const InputDecoration(labelText: 'Ví dụ '),
                ),
                TextFormField(
                  controller: _exampleMeaningController,
                  decoration: const InputDecoration(
                      labelText: 'Nghĩa của ví dụ '),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: _updateGrammar,
                    child: const Text('Cập nhật ngữ pháp'),
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
