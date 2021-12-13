import 'NoteSimple.dart';

class NotesData {
  List<NoteSimple> noteSimples;

  NotesData(this.noteSimples);

  factory NotesData.fromJson(Map<String, dynamic> json) {
    return NotesData(
      (json['notes'] as List).map((e) => NoteSimple.fromJson(e)).toList(),
    );
  }
}
