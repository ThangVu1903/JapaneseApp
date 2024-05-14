import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';
import 'package:japaneseleansflutter/page/home.dart';
import 'package:japaneseleansflutter/page/setting.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              "XIN CHÀO",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            accountEmail: Text("Vũ Thắng",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            decoration: BoxDecoration(
                color: yellow_1,
                image: DecorationImage(
                    image: AssetImage("asset/images/background_drawer.jpeg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            splashColor: yellow_1,
            title: const Text("Khoá học"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Cửa hàng"),
            onTap: () {},
            splashColor: yellow_1,
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text("Hướng dẫn"),
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
        ],
      ),
    );
  }
}
