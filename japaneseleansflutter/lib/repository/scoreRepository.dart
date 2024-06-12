import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/userScore.dart';

Future<void> submitScore(int? userId, int lessonId, double totalScore) async {
  // Địa chỉ URL của API endpoint
  final url = Uri.parse('http://192.168.1.215:8088/public/api/add/score');

  // Thực hiện POST request
  final response = await http.post(
    url,
    // Thiết lập headers để chỉ định loại nội dung là JSON
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // Mã hóa dữ liệu thành JSON để gửi trong body của request
    body: jsonEncode(<String, dynamic>{
      'userId': userId,
      'lessonId': lessonId,
      'totalScore': totalScore,
    }),
  );

  // Kiểm tra kết quả trả về từ server
  if (response.statusCode == 201) {
    // Nếu server trả về mã 201 (Created), in ra thông báo thành công
    print('Score submitted successfully');
  } else {
    // Nếu không, ném một ngoại lệ với thông báo lỗi
    throw Exception(
        'Failed to submit score. Response code: ${response.statusCode}');
  }
}

class ScoreRepository {
  Future<List<UserScore>> fetchUserScores(int lessonId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.215:8088/public/api/lesson/$lessonId/test/score'));

    if (response.statusCode == 200) {
      List<dynamic> scoresJson = json.decode(response.body);
      return scoresJson.map((json) => UserScore.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load scores');
    }
  }
}
