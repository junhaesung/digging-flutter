import 'perfume_simple.dart';

class BrandDetail {
  final int id;
  final String name;
  final List<PerfumeSimple> perfumes;

  const BrandDetail({
    required this.id,
    required this.name,
    required this.perfumes,
  });

  factory BrandDetail.fromJson(Map<String, dynamic> json) {
    return BrandDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      perfumes: (json['perfumes'] as List)
          .map((e) => PerfumeSimple.fromJson(e))
          .toList(),
    );
  }
}
