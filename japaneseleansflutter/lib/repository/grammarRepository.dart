import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:japaneseleansflutter/model/grammarModel.dart';

class GrammarRepository {
  Future<List<GrammarModel>> fetchGrammar(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.215:8088/public/api/lesson/$lessonNumber/grammar'));

    print(response.body);
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data =
          json.decode(decodedBody); // Decode response body
      final List<GrammarModel> vocabularies =
          data.map<GrammarModel>((vocabulary) {
        return GrammarModel.fromJson(
            vocabulary); // Create GrammarModel objects from JSON
      }).toList();
      return vocabularies;
    } else {
      throw Exception('Failed to load vocabulary');
    }
  }
}