import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:japaneseleansflutter/model/grammarModel.dart';

class GrammarRepository {
  Future<List<GrammarModel>> fetchGrammar(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:8088/public/api/lesson/$lessonNumber/grammar'));

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

  Future<void> addGrammar(int lessonId, String structure, String explainGrammar, String example, String exampleMeaning) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/lesson/add/grammar');

    final Map<String, dynamic> grammarData = {
      'lessonId': lessonId,
      'structure': structure,
      'explain_grammar': explainGrammar,
      'example': example,
      'example_meanning': exampleMeaning,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(grammarData),
      );

      if (response.statusCode == 201) {
        print('Grammar added successfully');
      } else {
        throw Exception('Failed to add grammar: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding grammar: $e');
    }
  }

  Future<void> updateGrammar(int grammarId,int lessonId, String structure, String explainGrammar, String example, String exampleMeaning) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/grammar/update/$grammarId');

    final Map<String, dynamic> grammarData = {
      'lessonId':lessonId,
      'structure': structure,
      'explain_grammar': explainGrammar,
      'example': example,
      'example_meanning': exampleMeaning,
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(grammarData),
      );

      if (response.statusCode == 200) {
        print('Grammar updated successfully');
      } else {
        throw Exception('Failed to update grammar: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating grammar: $e');
    }
  }

  Future<void> deleteGrammar(int grammarId) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/grammar/delete/$grammarId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        print('Grammar deleted successfully');
      } else {
        throw Exception('Failed to delete grammar: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting grammar: $e');
    }
  }
}