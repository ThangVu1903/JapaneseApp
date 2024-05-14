import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/component/navBar.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import '../component/course4.dart';
import '../component/course5.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _counter = 2;

  void _incrementCounter() {
    setState(() {
      _counter = _counter * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          drawer: const NavBar(),
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
                    CourseComponent_N5(size: size,
                    onPressed: (){

                    },),
                    CourseComponent_N4(size: size,onPressed: (){
                      
                    },),

                  ],
                )),
          )),
    );
  }
}
