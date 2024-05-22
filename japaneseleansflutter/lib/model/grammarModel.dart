class GrammarModel {
  final String structure;
  final String explain_grammar;
  final String example;
  final String example_meanning;

  GrammarModel(this.structure, this.explain_grammar, this.example, this.example_meanning);


  factory GrammarModel.fromJson(Map<String, dynamic> json) {
    return GrammarModel(
      json['structure'] as String,
      json['explain_grammar'] as String,
      json['example'] as String,
      json['example_meanning'] as String,
    );
  }
}

