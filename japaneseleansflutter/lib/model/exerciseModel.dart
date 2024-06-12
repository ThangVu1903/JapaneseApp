class ExerciseModel {
  final String type;
  final int questionNumber;
  final String questionContent;
  final String? kanjiQuestion;
  final String option1;
  final String option2;
  final String option3;
  final int correctOption;

  ExerciseModel({
    required this.type,
    required this.questionNumber,
    required this.questionContent,
    this.kanjiQuestion,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.correctOption,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      type: json['type'],
      questionNumber: json['question_number'],
      questionContent: json['question_content'],
      kanjiQuestion: json['kanji_question'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      correctOption: json['correct_option'],
    );
  }
}
