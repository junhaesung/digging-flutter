class NoteSimple {
  int id;
  String name;

  NoteSimple(this.id, this.name);

  factory NoteSimple.fromJson(Map<String, dynamic> json) {
    return NoteSimple(
      json['id'] as int,
      json['name'] as String,
    );
  }
}
