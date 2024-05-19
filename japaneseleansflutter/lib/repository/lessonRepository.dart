import 'package:dio/dio.dart';
import '../model/Lesson.dart';

class LessonRepository {
  final Dio _dio = Dio();

  Future<List<Lesson>> fetchLessons(String courseName) async {
    try {
      final response = await _dio.get(
        'http://192.168.1.213:8088/public/api/courses/$courseName/lesson',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<Lesson> lessons = data.map((lessonData) {
          return Lesson.formJson(lessonData);
        }).toList();
        return lessons;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("error:$e");
      throw Exception("error:$e");
    }
  }
}
