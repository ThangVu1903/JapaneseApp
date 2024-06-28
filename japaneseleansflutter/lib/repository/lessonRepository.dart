import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/Lesson.dart';

class LessonRepository {
  Future<List<Lesson>> fetchLessons(String courseName) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:8088/public/api/courses/$courseName/lesson'));

    print(response.body);
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data =
          json.decode(decodedBody); // Decode response body
      final List<Lesson> lessons = data.map<Lesson>((lesson) {
        return Lesson.formJson(lesson);
      }).toList();
      return lessons;
    } else {
      throw Exception('Failed to load lesson');
    }
  }
}
