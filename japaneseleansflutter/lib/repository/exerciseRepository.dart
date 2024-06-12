import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japaneseleansflutter/model/exerciseModel.dart';

class ExerciseRepository {
  Future<List<ExerciseModel>> fetchExercise(
      int lessonNumber, String type) async {
    final response = await http.get(Uri.parse(
        "http://192.168.1.215:8088/public/api/lesson/$lessonNumber/exercise/$type"));
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
}

class TestExerciseRepository {
  Future<List<ExerciseModel>> fetchTestExercise(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        "http://192.168.1.215:8088/public/api/lesson/$lessonNumber/exercise"));
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
}
