class VocabularyModel {
  final String hiragana;
  final String kanji;
  final String meanning;
  final String example;
  final String example_meanning;

  VocabularyModel(this.hiragana, this.kanji, this.meanning, this.example, this.example_meanning);

factory VocabularyModel.fromJson(Map<String, dynamic> json) {
    return VocabularyModel(
      json['hiragana'] as String,
      json['kanji'] as String,
      json['meanning'] as String,
      json['example'] as String,
      json['example_meanning'] as String,
    );
  }
}
