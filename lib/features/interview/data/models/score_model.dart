class ScoreModel {
  final double score;
  final String summary;
  final List chatHistory;
  final int durationInSeconds;

  const ScoreModel({
    required this.score,
    required this.summary,
    required this.durationInSeconds,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      "score": score,
      "summary": summary,
      "duration": durationInSeconds,
      "chat": chatHistory,
    };
  }

  factory ScoreModel.fromJson(dynamic json, int durationInSeconds) {
    return ScoreModel(
      score: json["score"].toDouble(),
      summary: json["summary"],
      chatHistory: json["chat"],
      durationInSeconds: durationInSeconds,
    );
  }
}
