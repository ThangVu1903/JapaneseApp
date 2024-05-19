class Lesson {
  final int lesson_number;
  final String lesson_name;

  Lesson({required this.lesson_number, required this.lesson_name});

  factory Lesson.formJson(Map<String, dynamic> json) {
    return Lesson(
        lesson_number: json['lesson_number'],
        lesson_name: json['lesson_name']);
  }
}
