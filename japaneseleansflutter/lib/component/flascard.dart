import 'package:flutter/material.dart';
import 'package:japaneseleansflutter/constants/colors.dart';

import 'dart:math';
import '../model/vocabularyModel.dart';
import '../repository/vocabularyReprsitory.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlashcardScreen extends StatefulWidget {
  final String lessonName;
  final int lessonNumber;
  const FlashcardScreen({
    Key? key,
    required this.lessonName,
    required this.lessonNumber,
  }) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with TickerProviderStateMixin {
  bool isSoundEnabled = true;
  final FlutterTts flutterTts = FlutterTts();
  final VocabularyRepository _repository = VocabularyRepository();
  late Future<List<VocabularyModel>> _futureVocabulary;
  late PageController _pageController;
  late AnimationController _animationController;
  final int _currentIndex = 0;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _initializeTts();
    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _futureVocabulary = _repository.fetchVocabulary(widget.lessonNumber);
  }

  void _initializeTts() {
    flutterTts.setLanguage('ja-JP');
    // Additional configuration for TTS like speed, volume, etc.
  }

  void _toggleSound() {
    setState(() {
      isSoundEnabled = !isSoundEnabled;
    });
  }

  void _speak(String text) async {
    if (isSoundEnabled && text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Giải phóng bộ nhớ khi widget bị loại bỏ khỏi cây widget
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard(VocabularyModel vocabularyModel) {
    if (!_isFront) {
      _speak(vocabularyModel.hiragana); // Phát âm từ vựng khi lật mặt sau
    }
    setState(() {
      _isFront =
          !_isFront; // Đảo ngược giá trị của _isFront để chuyển đổi giữa mặt trước và mặt sau
      if (_isFront) {
        _animationController.reverse(); // Lật ngược lại nếu đang ở mặt trước
      } else {
        _animationController.forward(); // Lật tiếp tục nếu đang ở mặt sau
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow_2,
        title: Text(
          "${widget.lessonName} / Flashcard ",
          style: const TextStyle(color: white_2),
        ),
      ),
      body: FutureBuilder<List<VocabularyModel>>(
        future: _futureVocabulary,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<VocabularyModel> vocabularies = snapshot.data!;
            int length = vocabularies.length;

            return Container(
              child: PageView.builder(
                controller: _pageController,
                itemCount: length,
                itemBuilder: (context, index) {
                  VocabularyModel vocabularyModel = vocabularies[index];

                  return Center(
                    child: GestureDetector(
                      onTap: () => _flipCard(vocabularyModel),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: MediaQuery.of(context).size.height * 2 / 3,
                        width: MediaQuery.of(context).size.width,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            // Xác định góc xoay dựa trên giá trị của animationController và giới hạn nó trong khoảng 180 độ
                            final rotationValue =
                                _animationController.value * pi;
                            var transform = Matrix4.identity()
                              ..setEntry(3, 2,
                                  0.001); // Thiết lập "depth" cho hiệu ứng 3D
                            transform.rotateY(rotationValue);

                            // Kiểm tra nếu giá trị xoay vượt quá 90 độ (pi/2), hiển thị mặt sau
                            final isFront = _animationController.value < 0.5;

                            // Tính toán góc xoay cho mặt sau để khi lật thẻ, mặt sau không bị ngược
                            double backRotation =
                                rotationValue > pi / 2 ? pi : 0;

                            return Transform(
                              alignment: Alignment.center,
                              transform: transform,
                              child: isFront
                                  ? _buildFrontCard(
                                      vocabularyModel, length, index)
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform:
                                          Matrix4.rotationY(backRotation),
                                      child: _buildBackCard(vocabularyModel),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFrontCard(
      VocabularyModel vocabularyModel, int length, int index) {
    return Card(
      color: yellow_1,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                vocabularyModel.kanji!,
                style: const TextStyle(
                    fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                vocabularyModel.hiragana,
                style: const TextStyle(
                    fontSize: 24.0, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 30.0),
              const Text(
                ("Ví dụ"),
                style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  vocabularyModel.example!= null ? vocabularyModel.example! : "", 
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
               
                vocabularyModel.example_meanning!= null ? vocabularyModel.example_meanning! : "", 
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: IconButton(
            icon: Icon(
              isSoundEnabled ? Icons.volume_up : Icons.volume_off,
              color: black,
            ),
            onPressed: _toggleSound,
          ),
        ),
        Positioned(
            top: 15,
            left: 10.0,
            child: Text(
              "${index + 1}/${length + 1}",
              style: const TextStyle(color: black, fontSize: 20),
            )),
      ]),
    );
  }

  Widget _buildBackCard(VocabularyModel vocabularyModel) {
    return Card(
      color: yellow_2,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(children: [
        Center(
          child: Text(
            vocabularyModel.meanning,
            style: const TextStyle(
                fontSize: 32.0, fontWeight: FontWeight.bold, color: white_2),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: IconButton(
            icon: Icon(
              isSoundEnabled ? Icons.volume_up : Icons.volume_off,
              color: Colors.white,
            ),
            onPressed: _toggleSound,
          ),
        ),
      ]),
    );
  }
}
