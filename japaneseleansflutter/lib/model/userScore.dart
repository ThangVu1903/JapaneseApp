class UserScore {
  final String username;
  final double totalScore;

  UserScore({required this.username, required this.totalScore});

  factory UserScore.fromJson(Map<String, dynamic> json) {
    return UserScore(
      username: json['username'] as String,
      totalScore: json['totalScore'] as double,
    );
  }
}