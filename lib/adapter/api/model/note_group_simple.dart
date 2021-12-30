class NoteGroupSimple {
  final int id;
  final String name;
  final String customName;

  NoteGroupSimple({
    required this.id,
    required this.name,
    required this.customName,
  });

  factory NoteGroupSimple.fromJson(Map<String, dynamic> json) {
    return NoteGroupSimple(
      id: json['id'] as int,
      name: json['name'] as String,
      customName: json['customName'] as String,
    );
  }
}
