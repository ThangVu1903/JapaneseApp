import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../model/vocabularyModel.dart';
import '../repository/vocabularyReprsitory.dart';

class ListVocabulary extends StatelessWidget {
  final String lessonName;
  final int lessonNumber;

  ListVocabulary(
      {super.key, required this.lessonNumber, required this.lessonName});

  final VocabularyRepository repository = VocabularyRepository();

  Future<List<VocabularyModel>> fetchVocabulary() async {
    return await repository.fetchVocabulary(lessonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow_2,
        title: Text(
          "Bài $lessonNumber : $lessonName / Danh sách từ vựng",
          style: const TextStyle(color: white_2, fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<VocabularyModel>>(
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
          color: const Color.fromARGB(255, 255, 190, 121),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          elevation: 15,
          child: ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.volume_up_outlined,
                  color: yellow_2,
                ),
                const Text("   "),
                Column(
                  children: [
                    Text(
                      vocabularies[index].hiragana,
                      style: const TextStyle(color: black, fontSize: 15),
                    ),
                    Text(
                      vocabularies[index].kanji!,
                      style: const TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      vocabularies[index].meanning,
                      style: const TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
