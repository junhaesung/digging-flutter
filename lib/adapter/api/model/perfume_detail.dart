import 'accord.dart';
import 'perfume_notes.dart';
import 'perfume_simple.dart';

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
          .map((e) => PerfumeSimple.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'PerfumeDetail{id: $id, name: $name, description: $description, gender: $gender, imageUrl: $imageUrl, thumbnailImageUrl: $thumbnailImageUrl, brandName: $brandName, accords: $accords, notes: $notes, perfumeSimples: $perfumeSimples}';
  }
}
