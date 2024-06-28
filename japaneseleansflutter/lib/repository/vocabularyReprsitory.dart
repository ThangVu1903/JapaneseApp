import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:japaneseleansflutter/constants/colors.dart';

import '../model/vocabularyModel.dart';

class VocabularyRepository {
  Future<List<VocabularyModel>> fetchVocabulary(int lessonNumber) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:8088/public/api/lesson/$lessonNumber/vocabulary'));

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

  Future<VocabularyModel> fetchVocabularyById(int vocabularyId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:8088/public/api/vocabulary/$vocabularyId')); // Thay đổi endpoint

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return VocabularyModel.fromJson(data);
    } else {
      throw Exception('Failed to load vocabulary');
    }
  }

  Future<void> addVocabulary(int lessonId, String hiragana, String? kanji,
      String meaning, String? example, String? exampleMeaning) async {
    final url =
        Uri.parse('http://192.168.1.24:8088/public/api/lesson/add/vocabulary');

    final Map<String, dynamic> vocabulary = {
      'lessonId': lessonId,
      'hiragana': hiragana,
      'kanji': kanji,
      'meanning': meaning,
      'example': example,
      'example_meanning': exampleMeaning,
    };
    print(vocabulary);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vocabulary),
      );

      if (response.statusCode == 201) {
        print("ok");
        // Xử lý tprihành công
      } else {
        // Xử lý lỗi
        throw Exception('Failed to add vocabulary: ${response.body}');
      }
    } catch (e) {
      // Xử lý ngoại lệ
      throw Exception('Error adding vocabulary: $e');
    }
  }

  Future<void> deleteVocabulary(int vocabularyId) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/lesson/delete/vocabulary/$vocabularyId'); // Endpoint xóa từ vựng

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        // Xóa thành công
        
      } else {
        // Xử lý lỗi
        throw Exception('Failed to delete vocabulary: ${response.body}');
      }
    } catch (e) {
      // Xử lý ngoại lệ (ví dụ: lỗi mạng)
      throw Exception('Error deleting vocabulary: $e');
    }
  }
  Future<void> updateVocabulary(
      int vocabularyId,
      int lessonId,
      String hiragana,
      String? kanji,
      String meaning,
      String? example,
      String? exampleMeaning
  ) async {
    final url = Uri.parse('http://192.168.1.24:8088/public/api/lesson/update/vocabulary/$vocabularyId'); // Endpoint cập nhật từ vựng

    final Map<String, dynamic> vocabularyData = {
      'lessonId':lessonId,
      'hiragana': hiragana,
      'kanji': kanji,
      'meanning': meaning,
      'example': example,
      'example_meanning': exampleMeaning,
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vocabularyData),
      );

      if (response.statusCode == 200) {
        // Cập nhật thành công
        print('Vocabulary updated successfully');
      } else {
        // Xử lý lỗi
        throw Exception('Failed to update vocabulary: ${response.body}');
      }
    } catch (e) {
      // Xử lý ngoại lệ
      throw Exception('Error updating vocabulary: $e');
    }
  }
}
