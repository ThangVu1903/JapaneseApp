import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:japaneseleansflutter/model/exerciseModel.dart';

class ExerciseRepository {
  Future<List<ExerciseModel>> fetchExercise(
      int lessonNumber, String type) async {
    final response = await http.get(Uri.parse(
        "http://192.168.1.24:8088/public/api/lesson/$lessonNumber/exercise/$type"));
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(decodedBody);
      final List<ExerciseModel> exercises = data.map<ExerciseModel>((exercise) {
        return ExerciseModel.fromJson(exercise);
      }).toList();
      return exercises;
    } else {
      throw Exception('Failed to load exercise');
    }
  }



  Future<List<ExerciseModel>> fetchTestExercise(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        "http://192.168.1.24:8088/public/api/lesson/$lessonNumber/exercise"));
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(decodedBody);
      final List<ExerciseModel> exercises = data.map<ExerciseModel>((exercise) {
        return ExerciseModel.fromJson(exercise);
      }).toList();
      return exercises;
    } else {
      throw Exception('Failed to load test');
    }
  }

  Future<void> addExercise(
      int lessonId,
      String type,
      int questionNumber,
      String? kanjiQuestion,
      String questionContent,
      String option1,
      String option2,
      String option3,
      int correctOption) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/lesson/test/add'); // Endpoint thêm bài tập

    final Map<String, dynamic> exerciseData = {
      'lessonId': lessonId,
      'type': type,
      'questionNumber': questionNumber,
      'kanjiQuestion': kanjiQuestion,
      'questionContent': questionContent,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'correctOption': correctOption,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(exerciseData),
      );

      if (response.statusCode == 201) {
        print('Exercise added successfully');
      } else {
        throw Exception('Failed to add exercise: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding exercise: $e');
    }
  }

  Future<void> updateExercise(
    int exerciseId,
    int lesssonId,
    String type,
    int questionNumber,
    String? kanjiQuestion,
    String questionContent,
    String option1,
    String option2,
    String option3,
    int correctOption,
  ) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/lesson/test/udate/$exerciseId'); // Endpoint cập nhật bài tập

    final Map<String, dynamic> exerciseData = {
      
      'type': type,
      'questionNumber': questionNumber,
      'kanjiQuestion': kanjiQuestion,
      'questionContent': questionContent,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'correctOption': correctOption,
      'lessonId':lesssonId
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(exerciseData),
      );

      if (response.statusCode == 200) {
        print('Exercise updated successfully');
      } else {
        throw Exception('Failed to update exercise: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating exercise: $e');
    }
  }

  Future<void> deleteExercise(int exerciseId) async {
    final url =
        Uri.parse('http://192.168.1.24:8088/public/api/lesson/test/delete/$exerciseId'); // Endpoint xóa bài tập

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        // Xóa thành công
        print('Exercise deleted successfully');
      } else {
        // Xử lý lỗi
        throw Exception('Failed to delete exercise: ${response.body}');
      }
    } catch (e) {
      // Xử lý ngoại lệ (ví dụ: lỗi mạng)
      throw Exception('Error deleting exercise: $e');
    }
  }
}
