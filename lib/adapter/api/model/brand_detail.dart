import 'perfume_simple.dart';

class BrandDetail {
  final int id;
  final String name;
  final String thumbnailImageUrl;
  final List<PerfumeSimple> perfumes;

  const BrandDetail({
    required this.id,
    required this.name,
    required this.thumbnailImageUrl,
    required this.perfumes,
  });

  factory BrandDetail.fromJson(Map<String, dynamic> json) {
    return BrandDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      // TODO: rename api fields
      thumbnailImageUrl: json['image'],
      // TODO: rename api fields
      perfumes: (json['recommendPerfumes'] as List).map((e) => PerfumeSimple.fromJson(e)).toList(),
    );
  }
}
