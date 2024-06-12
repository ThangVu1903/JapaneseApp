import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/vocabularyModel.dart';

class VocabularyRepository {
  Future<List<VocabularyModel>> fetchVocabulary(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.215:8088/public/api/lesson/$lessonNumber/vocabulary'));

    print(response.body);
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data =
          json.decode(decodedBody); // Decode response body
      final List<VocabularyModel> vocabularies =
          data.map<VocabularyModel>((vocabulary) {
        return VocabularyModel.fromJson(
            vocabulary); // Create VocabularyModel objects from JSON
      }).toList();
      return vocabularies;
    } else {
      throw Exception('Failed to load vocabulary');
    }
  }
}
