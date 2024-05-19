import 'package:dio/dio.dart';

class SignupController {
  Future<void> signUp(String email, String password) async {
    try {
      const String apiUrl = 'http://example.com/signup';
      final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };

      final Dio dio = Dio();
      final Response response = await dio.post(
        apiUrl,
        data: body,
      );

      // Xử lý phản hồi từ API
      // ...
    } catch (e) {
      // Xử lý lỗi kết nối hoặc lỗi khác
      // ...
    }
  }
}