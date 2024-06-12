import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupRepository {
  Future<void> signUp(String email, String username, String password,
      BuildContext context) async {
    const String apiUrl = 'http://192.168.1.215:8088/auth/register';
    final Uri apiUri = Uri.parse(apiUrl);
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'email': email,
      'username': username,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        apiUri,
        headers: headers,
        body: json.encode(body),
      );

      // Check the response status code and handle accordingly

      dynamic bodyb = jsonDecode(response.body);

      switch (bodyb['statusCode']) {
        case 200:
        case 201:
          // Success
          showToast("Đăng ký thành công!", Colors.green);
          Navigator.pop(context);
          break;
        case 400:
          // Bad request, possibly user already exists
          showToast("Email này đã có người đăng ký, vui lòng dùng email khác",
              Colors.red);
          break;
        default:
          // Other cases, such as 500 Internal Server Error
          showToast(
              "Đăng ký không thành công. Vui lòng thử lại sau.", Colors.red);
      }
    } catch (e) {
      // Handle errors like no internet connection, timeout, etc.
      showToast("Đã xảy ra lỗi: $e", Colors.red);
    }
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
