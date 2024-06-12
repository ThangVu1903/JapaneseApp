import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/vocabularyModel.dart';
import '../repository/vocabularyReprsitory.dart';

class VocabularyAdmin extends StatelessWidget {
  late int lessonNumber;
  VocabularyAdmin({required this.lessonNumber, super.key});

  final VocabularyRepository repository = VocabularyRepository();
  Future<List<VocabularyModel>> fetchVocabulary() async {
    return await repository.fetchVocabulary(lessonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: FutureBuilder<List<VocabularyModel>>(
          future: fetchVocabulary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No vocabulary found.'));
            } else {
              return VocabularyList(vocabularies: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class VocabularyList extends StatelessWidget {
  final List<VocabularyModel> vocabularies;

  const VocabularyList({super.key, required this.vocabularies});

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
                          vocabulary.kanji,
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
                        // Thêm hành động cho nút sửa ở đây
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
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
