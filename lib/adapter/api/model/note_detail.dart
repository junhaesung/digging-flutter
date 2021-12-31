import 'package:digging/adapter/api/model/perfume_simple.dart';

class NoteDetail {
  final int id;
  final String name;
  final List<PerfumeSimple> perfumes;

  NoteDetail({
    required this.id,
    required this.name,
    required this.perfumes,
  });

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      perfumes: (json['perfumes'] as List)
          .map((e) => PerfumeSimple.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'NoteDetail{id: $id, name: $name, perfumes: $perfumes}';
  }
}
