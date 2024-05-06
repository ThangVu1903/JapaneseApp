import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late PageController
      _pageController; // Sử dụng PageController để điều khiển trang trong PageView
  late AnimationController
      _animationController; // Sử dụng AnimationController để điều khiển hiệu ứng xoay

  final List<Map<String, String>> _flashcards = [
    {'hiragana': 'あ', 'meaning': 'A'},
    {'hiragana': 'い', 'meaning': 'I'},
    {'hiragana': 'う', 'meaning': 'U'},
    {'hiragana': 'え', 'meaning': 'E'},
    {'hiragana': 'お', 'meaning': 'O'},
  ];

  final int _currentIndex = 0; // Chỉ số của flashcard hiện tại

  bool _isFront =
      true; // Biến boolean để xác định mặt trước hoặc mặt sau của flashcard

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentIndex); // Khởi tạo PageController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Giải phóng bộ nhớ khi widget bị loại bỏ khỏi cây widget
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard() {
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
        title: const Text('Flashcard App'),
      ),
      body: GestureDetector(
        onTap: _flipCard, // Khi chạm vào flashcard, lật nó
        child: PageView.builder(
          // Sử dụng PageView.builder để tạo danh sách các flashcard
          controller:
              _pageController, // Sử dụng PageController để điều khiển trang
          itemCount: _flashcards.length, // Số lượng flashcard
          itemBuilder: (context, index) {
            final flashcard =
                _flashcards[index]; // Lấy flashcard tại vị trí index
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 3,
                width: MediaQuery.of(context).size.width,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(_isFront
                            ? _animationController.value.abs() * 3.14
                            : (_animationController.value.abs() - 1.0) * 3.14),
                      child: child,
                    );
                  },
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        _isFront
                            ? flashcard['hiragana']!
                            : flashcard['meaning']!,
                        style: const TextStyle(
                            fontSize: 48.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
