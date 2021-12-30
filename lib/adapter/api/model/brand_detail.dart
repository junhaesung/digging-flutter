import 'perfume_simple.dart';

class BrandDetail {
  int id;
  String name;
  List<PerfumeSimple> perfumes;

  BrandDetail(this.id, this.name, this.perfumes);

  factory BrandDetail.fromJson(Map<String, dynamic> json) {
    return BrandDetail(
        json['id'] as int,
        json['name'] as String,
        (json['perfumes'] as List).map((e) => PerfumeSimple.fromJson(e)).toList(),
    );
  }
}