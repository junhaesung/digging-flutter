import 'package:digging/adapter/api/model/note_detail.dart';

class RecommendNoteGroups {
  final int id;
  final String name;
  final List<NoteDetail> recommendNotes;

  RecommendNoteGroups({
    required this.id,
    required this.name,
    required this.recommendNotes,
  });

  factory RecommendNoteGroups.fromJson(Map<String, dynamic> json) {
    return RecommendNoteGroups(
      id: json['id'] as int,
      name: json['name'] as String,
      recommendNotes: (json['recommendNotes'] as List)
          .map((e) => NoteDetail.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'RecommendNoteGroups{id: $id, name: $name, recommendNotes: $recommendNotes}';
  }
}
