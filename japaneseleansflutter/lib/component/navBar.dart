import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/page/setting.dart';

import '../page/login.dart';

class NavBar extends StatelessWidget {
  String username;
  String email;
  NavBar({required this.username, required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "XIN CHÀO",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            accountEmail: Text(username,
                style: const TextStyle(color: Colors.black, fontSize: 20)),
            decoration: const BoxDecoration(
              color: yellow_1,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            splashColor: yellow_1,
            title: const Text("Khoá học"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Cửa hàng"),
            onTap: () {},
            splashColor: yellow_1,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Setting()));
            },
            splashColor: yellow_1,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Đăng xuất"),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
            splashColor: yellow_1,
          ),
        ],
      ),
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
}
