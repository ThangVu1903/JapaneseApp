import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/admin/lessonDetailAdmin.dart';
import 'package:japaneseleansflutter/page/login.dart';

import '../constants/colors.dart';
import '../model/Lesson.dart';
import '../repository/lessonRepository.dart';

class AdminDashboard extends StatefulWidget {
  String username;
  String email;
  AdminDashboard({required this.username, required this.email, super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String currentCourseName = "N5";

  late final LessonRepository lessonRepository = LessonRepository();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text(widget.email),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.account_circle),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.play_lesson),
              title: const Text('Bài học'),
              onTap: () {
                // Handle your onTap here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Tài khoản'),
              onTap: () {
                // Handle your onTap here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleAdminCourse("N5");
                      },
                      child: Container(
                        //flashcar

                        width: size.width * 2 / 5,
                        height: size.height * 1 / 5 * 4 / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: yellow_2,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 40,
                                  offset: Offset(8, 20))
                            ]),
                        child: Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child:
                                    Image.asset('asset/icons/flash-cards.png')),
                            const Text(
                              "N5",
                              style: TextStyle(
                                  color: white_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handleAdminCourse("N4");
                      },
                      child: Container(
                        //flashcar

                        width: size.width * 2 / 5,
                        height: size.height * 1 / 5 * 4 / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: yellow_2,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 40,
                                  offset: Offset(8, 20))
                            ]),
                        child: Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child:
                                    Image.asset('asset/icons/flash-cards.png')),
                            const Text(
                              "N4",
                              style: TextStyle(
                                  color: white_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: black,
                ),
              ),
              Visibility(
                visible: true,
                child: Expanded(
                  child: FutureBuilder<List<Lesson>>(
                      future: lessonRepository.fetchLessons(currentCourseName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<Lesson>? lessons = snapshot.data;
                          return ListView.builder(
                              itemCount: lessons!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: yellow_2,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  elevation: 15,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Image.asset("asset/icons/learning.png"),
                                        Text(
                                          '    Bài ${lessons[index].lesson_number}: ${lessons[index].lesson_name}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LessonDetailAdmin(
                                                  lessonNumber: lessons[index]
                                                      .lesson_number,
                                                  lessonName: lessons[index]
                                                      .lesson_name,
                                                )),
                                      );
                                    },
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ),
            ],
          )),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có muốn đăng xuất không ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Có'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void handleAdminCourse(String courseName) {
    setState(() {
      currentCourseName = courseName;
    });
  }
}
