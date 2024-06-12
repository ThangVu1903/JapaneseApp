import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/page/login.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => User(email: '', password: ''), // Khởi tạo User với thông tin rỗng
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
