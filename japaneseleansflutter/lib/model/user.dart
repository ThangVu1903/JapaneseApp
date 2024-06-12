import 'package:flutter/foundation.dart';
class User with ChangeNotifier {
  final String email;
  final String password;
  int? _userId;

  User({required this.email, required this.password, int? userId}) : _userId = userId;

  int? get userId => _userId;

  set userId(int? value) {
    _userId = value;
    notifyListeners(); // Thông báo cho listeners về sự thay đổi
  }
}