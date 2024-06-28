import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/model/grammarModel.dart';
import 'package:japaneseleansflutter/repository/grammarRepository.dart';

import '../component/exercise.dart';
import '../constants/colors.dart';

class Grammar extends StatefulWidget {
  final String lessonName;
  final int lessonNumber;

  const Grammar(
      {super.key, required this.lessonNumber, required this.lessonName});

  @override
  State<Grammar> createState() => _GrammarState();
}

class _GrammarState extends State<Grammar> {
  final GrammarRepository repository = GrammarRepository();
  late Future<List<GrammarModel>> _futureGrammars;
  late List<bool> _isOpen;

  @override
  void initState() {
    super.initState();
    _futureGrammars = fetchGrammar();
  }

  Future<List<GrammarModel>> fetchGrammar() async {
    List<GrammarModel> grammars =
        await repository.fetchGrammar(widget.lessonNumber);
    _isOpen = List<bool>.filled(grammars.length, false);
    return grammars;
  }

  handleExercise(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ExerciseScreen(
            type: "grammar",
            lessonNumber: widget.lessonNumber,
          );
        },
        settings: const RouteSettings(name: "Grammar"),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: white_2,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [yellow_1, yellow_2],
              ),
            ),
            width: size.width,
            height: 50,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    "Ngữ pháp",
                    style: TextStyle(
                      fontSize: 20, // Đặt kích thước chữ là 24
                      fontWeight: FontWeight.bold, // Đặt đậm
                      color: Colors.white, // Đặt màu trắng
                      fontFamily: 'Roboto', // Đặt font chữ
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: white_2,
            width: size.width,
            height: size.height * 1 / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    handleExercise(context);
                  },
                  child: Container(
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('asset/icons/planning.png')),
                        const Text(
                          "Luyện tập",
                          style: TextStyle(
                              color: white_1,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  //flashcar Text

                  width: size.width * 2 / 5,
                  height: size.height * 1 / 5 * 4 / 5,
                  child: const Column(
                    children: [
                      Text("Học kiến thức trước nha ! ",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      Text("Nhớ hoàn thành khi có thông báo nhé ! ",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Kiến thức",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            color: black,
          ),
          Expanded(
            child: FutureBuilder<List<GrammarModel>>(
              future: _futureGrammars,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Chưa có data.'));
                } else {
                  final List<GrammarModel> grammars = snapshot.data!;
                  return ListView.builder(
                    itemCount: grammars.length,
                    itemBuilder: (context, index) {
                      final grammar = grammars[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Card(
                              color: yellow_2,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              elevation: 15,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      '${index + 1}. ${grammar.structure}',
                                      style: const TextStyle(
                                          color: white_1, fontSize: 15),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _isOpen[index] = !_isOpen[index];
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                              visible: _isOpen[index],
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: yellow_1,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Giải thích: ${grammar.explain_grammar}',
                                        style: const TextStyle(
                                            color: black, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Ví dụ",
                                          style: TextStyle(
                                              color: black, fontSize: 18)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(grammar.example! ?? " ",
                                          style: const TextStyle(
                                              color: black, fontSize: 18)),
                                      Text(grammar.example_meanning!??" " ,
                                          style: const TextStyle(
                                              color: black, fontSize: 18)),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
