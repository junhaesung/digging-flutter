class Accord {
  String name;
  double score;
  double opacity;
  String backgroundColor;
  String textColor;

  Accord(this.name, this.score, this.opacity, this.backgroundColor,
      this.textColor);

  factory Accord.fromJson(Map<String, dynamic> json) {
    return Accord(
      json['name'] as String,
      json['score'] as double,
      json['opacity'] as double,
      json['backgroundColor'] as String,
      json['textColor'] as String,
    );
  }

  @override
  String toString() {
    return 'Accord{name: $name, score: $score, opacity: $opacity, backgroundColor: $backgroundColor, textColor: $textColor}';
  }
}
