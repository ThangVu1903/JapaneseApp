import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:japaneseleansflutter/admin/addVocabulary.dart';
import '../constants/colors.dart';
import '../model/vocabularyModel.dart';
import '../repository/vocabularyReprsitory.dart';
import 'editVocabularyScreen.dart';

class VocabularyAdmin extends StatefulWidget {
  final int lessonNumber;

  const VocabularyAdmin({required this.lessonNumber, super.key});

  @override
  _VocabularyAdminState createState() => _VocabularyAdminState();
}

class _VocabularyAdminState extends State<VocabularyAdmin> {
  final VocabularyRepository _repository = VocabularyRepository();
  late Future<List<VocabularyModel>> _vocabularies;

  @override
  void initState() {
    super.initState();
    _loadVocabularies();
  }

  Future<void> _loadVocabularies() async {
    setState(() {
      _vocabularies = _repository.fetchVocabulary(widget.lessonNumber);
    });
  }

  void _deleteVocabulary(int vocabularyId) async {
    try {
      await _repository.deleteVocabulary(vocabularyId);
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: white_1,
        gravity: ToastGravity.TOP,
        msg: "Xoá thành công!",
      );
      _loadVocabularies(); // Reload the list after deleting
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi xóa từ vựng: $e')),
      );
    }
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
              builder: (context) => AddVocabularyScreen(
                lessonNumber: widget.lessonNumber,
              ),
            ),
          ).then(
              (value) => _loadVocabularies()); // Reload the list after adding
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<VocabularyModel>>(
        future: _vocabularies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No vocabulary found.'));
          } else {
            return VocabularyList(
                vocabularies: snapshot.data!,
                onDelete: _deleteVocabulary,
                lessonNumber: widget.lessonNumber);
          }
        },
      ),
    );
  }
}

class VocabularyList extends StatelessWidget {
  final List<VocabularyModel> vocabularies;
  final Function(int) onDelete;
  final int lessonNumber;
  const VocabularyList({
    super.key,
    required this.vocabularies,
    required this.onDelete,
    required this.lessonNumber,
  });

  void _showDeleteConfirmationDialog(
      BuildContext context, VocabularyModel vocabulary) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text(
              'Bạn có chắc chắn muốn xóa từ vựng "${vocabulary.hiragana}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete(vocabulary.vocabulary_id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vocabularies.length,
      itemBuilder: (context, index) {
        final vocabulary = vocabularies[index];
        return Card(
          color: yellow_1,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          elevation: 15,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vocabulary.hiragana,
                          style: const TextStyle(color: black, fontSize: 15),
                        ),
                        Text(
                          vocabulary.kanji != null ? vocabulary.kanji! : "",
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          vocabulary.meanning,
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                // Cột chứa các biểu tượng
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVocabularyScreen(
                              vocabulary: vocabulary,
                              lessonNumber: lessonNumber,
                            ), // Truyền vocabulary vào màn hình sửa
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, vocabulary);
                        // Thêm hành động cho nút xoá ở đây
                      },
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
