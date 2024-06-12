import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/repository/scoreRepository.dart';

import '../model/userScore.dart';

class TestRanK extends StatefulWidget {
  int lessonNumber;
  TestRanK({required this.lessonNumber, super.key});

  @override
  State<TestRanK> createState() => _TestRanKState();
}

class _TestRanKState extends State<TestRanK> {
  late Future<List<UserScore>> futureScores;
  final ScoreRepository scoreRepository = ScoreRepository();
  @override
  void initState() {
    super.initState();
    futureScores = scoreRepository.fetchUserScores(widget.lessonNumber + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow_1,
        title: const Text(
          "Bảng xếp hạng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserScore>>(
        future: futureScores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Đã xảy ra lỗi: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
                child: Text("Chưa có ai kiểm tra",
                    style: TextStyle(fontSize: 20)));
          } else if (snapshot.hasData) {
            List<UserScore>? scores = snapshot.data;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: scores?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: yellow_2,
                      child: Text(scores![index].username[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(scores[index].username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                        '${scores[index].totalScore} điểm       Top ${index + 1}',
                        style: const TextStyle(
                            color: yellow_2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 32),
            );
          } else {
            return const Center(child: Text("Không có dữ liệu"));
          }
        },
      ),
    );
  }
}
