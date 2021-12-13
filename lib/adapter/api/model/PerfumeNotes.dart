class PerfumeNotes {
  List<String> topNames;
  List<String> middleNames;
  List<String> baseNames;
  List<String> unknownNames;

  PerfumeNotes(
      this.topNames, this.middleNames, this.baseNames, this.unknownNames);

  factory PerfumeNotes.fromJson(Map<String, dynamic> json) {
    return PerfumeNotes(
      (json['top'] as List).map((e) => e as String).toList(),
      (json['middle'] as List).map((e) => e as String).toList(),
      (json['base'] as List).map((e) => e as String).toList(),
      (json['unknown'] as List).map((e) => e as String).toList(),
    );
  }
}
