import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japaneseleansflutter/component/navBar.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/repository/lessonRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/course4.dart';
import '../component/course5.dart';
import '../model/user.dart';
import 'listLesson.dart';

class Home extends StatefulWidget {
  String username;
  String email;
  Home({required this.username, required this.email, super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late final LessonRepository lessonRepository = LessonRepository();

  @override
  void initState() {
    super.initState();
    _logout();
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    int? userId = Provider.of<User>(context, listen: false).userId;
    print(userId);
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed, // thoát ứng dụng
      child: SafeArea(
        child: Scaffold(
            drawer: NavBar(
              username: widget.username,
              email: widget.email,
            ),
            appBar: AppBar(
              backgroundColor: yellow_1,
              title: const Text(
                'Khoá học',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  "Thông báo",
                                  textAlign: TextAlign.center,
                                ),
                                content: Container(
                                  height: size.height * 1 / 2,
                                  color: white_1,
                                ),
                              ));
                    },
                    icon: Image.asset('asset/icons/bell.png'))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  width: size.width,
                  height: size.height,
                  color: yellow_1,
                  child: Column(
                    children: [
                      CourseComponent_N5(
                        size: size,
                        onPressed: () {
                          _navigateToCourseListScreen(context, 'N5');
                        },
                      ),
                      CourseComponent_N4(
                        size: size,
                        onPressed: () {
                          _navigateToCourseListScreen(context, 'N4');
                        },
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Thoát ứng dụng?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Bạn có chắc chắn muốn thoát ứng dụng không?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Không',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // Đóng ứng dụng
            },
            child: const Text('Có',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _navigateToCourseListScreen(BuildContext context, String courseName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonList(
            courseName: courseName, lessonRepository: lessonRepository),
      ),
    );
  }
}
