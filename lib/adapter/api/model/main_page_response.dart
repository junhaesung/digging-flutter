import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/adapter/api/model/recommend_note_group.dart';
import 'package:digging/adapter/api/model/recommend_perfumes.dart';

class MainPageResponse {
  final bool hasOnboarded;
  final List<BrandSimple> popularBrands;
  final List<RecommendPerfumes> recommendPerfumes;
  final List<RecommendNoteGroup> recommendNoteGroups;

  MainPageResponse({
    required this.hasOnboarded,
    required this.popularBrands,
    required this.recommendPerfumes,
    required this.recommendNoteGroups,
  });

  factory MainPageResponse.fromJson(Map<String, dynamic> json) {
    return MainPageResponse(
      hasOnboarded: json['hasOnboarded'] as bool,
      popularBrands: (json['popularBrands'] as List)
          .map((e) => BrandSimple.fromJson(e))
          .toList(),
      recommendPerfumes: (json['recommendPerfumes'] as List)
          .map((e) => RecommendPerfumes.fromJson(e))
          .toList(),
      recommendNoteGroups: (json['recommendNoteGroups'] as List)
          .map((e) => RecommendNoteGroup.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'MainPageResponse{hasOnboarded: $hasOnboarded, popularBrands: $popularBrands, recommendPerfumes: $recommendPerfumes, recommendNoteGroups: $recommendNoteGroups}';
  }
}
