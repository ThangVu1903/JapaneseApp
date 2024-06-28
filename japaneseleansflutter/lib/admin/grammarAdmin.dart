import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/admin/addGrammarScreen.dart';
import 'package:japaneseleansflutter/admin/editGrammarScreen.dart';

import '../constants/colors.dart';
import '../model/grammarModel.dart';
import '../repository/grammarRepository.dart';

class GrammarAdmin extends StatefulWidget {
  final int lessonNumber;

  const GrammarAdmin({required this.lessonNumber, super.key});

  @override
  State<GrammarAdmin> createState() => _GrammarAdminState();
}

class _GrammarAdminState extends State<GrammarAdmin> {
  final GrammarRepository repository = GrammarRepository();
  late Future<List<GrammarModel>> _futureGrammars;
  late List<bool> _isOpen;

  @override
  void initState() {
    super.initState();
    _loadGrammars(); // Gọi hàm để tải dữ liệu
  }

  Future<void> _loadGrammars() async {
    setState(() {
      _futureGrammars = fetchGrammar();
    });
  }

  Future<List<GrammarModel>> fetchGrammar() async {
    List<GrammarModel> grammars =
        await repository.fetchGrammar(widget.lessonNumber);
    _isOpen = List<bool>.filled(grammars.length, false);
    return grammars;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: white_1,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGrammarScreen(
                lessonNumber: widget.lessonNumber,
              ),
            ),
          ).then(
              (value) => _loadGrammars()); // Refresh grammar list after adding
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<GrammarModel>>(
        future: _futureGrammars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có data.'));
          } else {
            final List<GrammarModel> grammars = snapshot.data!;
            return ListView.builder(
              itemCount: grammars.length,
              itemBuilder: (context, index) {
                final grammar = grammars[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Card(
                        color: yellow_2,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 15,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${index + 1}. ${grammar.structure}',
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: white_1, fontSize: 17),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditGrammarScreen(
                                            grammar: grammar,
                                            lessonNumber: widget.lessonNumber,
                                          ),
                                        ),
                                      ).then((value) =>
                                          _loadGrammars()); // Reload the list after editing
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      _showDeleteConfirmationDialog(
                                          context, grammar);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _isOpen[index] = !_isOpen[index];
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _isOpen[index],
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: size.width,
                          decoration: BoxDecoration(
                              color: yellow_1,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Text(
                                  'Giải thích: ${grammar.explain_grammar}',
                                  style: const TextStyle(
                                      color: black, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Ví dụ",
                                    style:
                                        TextStyle(color: black, fontSize: 18)),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(grammar.example ?? " ",
                                    style: const TextStyle(
                                        color: black, fontSize: 18)),
                                Text(grammar.example_meanning ?? " ",
                                    style: const TextStyle(
                                        color: black, fontSize: 18)),
                              ],
                            ),
                          ),
                        )),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, GrammarModel grammar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text(
              'Bạn có chắc chắn muốn xóa ngữ pháp "${grammar.structure}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                try {
                  await GrammarRepository().deleteGrammar(grammar.grammar_id);
                  Navigator.of(context).pop();
                  _loadGrammars(); // Gọi lại hàm để tải lại danh sách
                  Fluttertoast.showToast(
                    backgroundColor: Colors.green,
                    textColor: white_1,
                    gravity: ToastGravity.TOP,
                    msg: "Xoá thành công!",
                  );
                } catch (e) {
                  print('Lỗi khi xóa ngữ pháp: $e');
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
}
