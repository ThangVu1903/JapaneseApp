import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/page/testLesson.dart';
import 'package:japaneseleansflutter/page/vocabulary.dart';

import '../constants/colors.dart';
import 'grammar.dart';

class DetailLesson extends StatefulWidget {
  final String lessonName;
  final int lessonNumber;
  const DetailLesson(
      {Key? key, required this.lessonName, required this.lessonNumber})
      : super(key: key);

  @override
  State<DetailLesson> createState() => _DetailLessonState();
}

class _DetailLessonState extends State<DetailLesson>
    with SingleTickerProviderStateMixin<DetailLesson> {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_2,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: yellow_1,
        title: Text(
          "Bài ${widget.lessonNumber}: ${widget.lessonName}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        TabBarView(
          controller: _tabController,
          children: [
            Vocabulary(
                lessonName: widget.lessonName,
                lessonNumber: widget.lessonNumber),
            Grammar(
              lessonName: widget.lessonName,
              lessonNumber: widget.lessonNumber,
            ),
             TestLesson(
              lessonName: widget.lessonName,
              lessonNumber: widget.lessonNumber,
            ),
            //DraggableChatBubble(),
            //
          ],
        ),
      ]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 40,
              offset: const Offset(8, 20),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CupertinoTabBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            activeColor: yellow_2,
            inactiveColor: Colors.black,
            onTap: (index) {
              _tabController.animateTo(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.abc_outlined),
                label: "Từ Vựng",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_decrease_outlined),
                label: "Ngữ Pháp",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist_rtl_outlined),
                label: "Kiểm Tra",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
