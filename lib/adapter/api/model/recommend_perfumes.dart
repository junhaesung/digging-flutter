import 'package:digging/adapter/api/model/perfume_simple.dart';

class RecommendPerfumes {
  const RecommendPerfumes({required this.perfumes});

  final List<PerfumeSimple> perfumes;

  factory RecommendPerfumes.fromJson(Map<String, dynamic> json) {
    return RecommendPerfumes(
      perfumes: (json['perfumes'] as List)
          .map((e) => PerfumeSimple.fromJson2(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'RecommendPerfumes{perfumes: $perfumes}';
  }
}
