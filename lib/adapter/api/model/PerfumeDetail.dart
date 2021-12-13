import 'Accord.dart';
import 'PerfumeNotes.dart';
import 'PerfumeSimple.dart';

class PerfumeDetail {
  int id;
  String name;
  String description;
  String gender;
  String imageUrl;
  String thumbnailImageUrl;
  String brandName;
  List<Accord> accords;
  PerfumeNotes notes;
  List<PerfumeSimple> perfumeSimples;

  PerfumeDetail(
    this.id,
    this.name,
    this.description,
    this.gender,
    this.imageUrl,
    this.thumbnailImageUrl,
    this.brandName,
    this.accords,
    this.notes,
    this.perfumeSimples,
  );

  factory PerfumeDetail.fromJson(Map<String, dynamic> json) {
    return PerfumeDetail(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['gender'] as String,
      json['imageUrl'] as String,
      json['thumbnailImageUrl'] as String,
      json['brandName'] as String,
      (json['accords'] as List).map((e) => Accord.fromJson(e)).toList(),
      PerfumeNotes.fromJson(json['notes']),
      (json['similarPerfumes'] as List)
          .map((e) => PerfumeSimple.fromJson2(e))
          .toList(),
    );
  }
}
