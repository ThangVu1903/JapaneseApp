import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/grammarModel.dart';
import '../repository/grammarRepository.dart';

class GrammarAdmin extends StatefulWidget {
  late int lessonNumber;
  GrammarAdmin({required this.lessonNumber, super.key});

  @override
  State<GrammarAdmin> createState() => _GrammarAdminState();
}

class _GrammarAdminState extends State<GrammarAdmin> {
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<GrammarModel>>(
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
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      elevation: 15,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${index + 1}. ${grammar.structure}',
                              style:
                                  const TextStyle(color: white_1, fontSize: 15),
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
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                style:
                                    const TextStyle(color: black, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Ví dụ",
                                  style: TextStyle(color: black, fontSize: 18)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(grammar.example,
                                  style: const TextStyle(
                                      color: black, fontSize: 18)),
                              Text(grammar.example_meanning,
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
    );
  }
}
