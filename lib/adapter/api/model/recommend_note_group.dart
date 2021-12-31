import 'package:digging/adapter/api/model/note_detail.dart';

class RecommendNoteGroup {
  final int id;
  final String name;
  final List<NoteDetail> recommendNotes;

  RecommendNoteGroup({
    required this.id,
    required this.name,
    required this.recommendNotes,
  });

  factory RecommendNoteGroup.fromJson(Map<String, dynamic> json) {
    return RecommendNoteGroup(
      id: json['id'] as int,
      name: json['name'] as String,
      recommendNotes: (json['notes'] as List)
          .map((e) => NoteDetail.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'RecommendNoteGroups{id: $id, name: $name, recommendNotes: $recommendNotes}';
  }
}
