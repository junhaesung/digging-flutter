import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/adapter/api/model/perfume_simple.dart';
import 'package:equatable/equatable.dart';

class SearchResponse extends Equatable{
  SearchResponse({
    this.brands,
    this.perfumes,
  });

  final List<BrandSimple>? brands;
  final List<PerfumeSimple>? perfumes;

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      brands:
          (json['brands'] as List).map((e) => BrandSimple.fromJson(e)).toList(),
      perfumes: (json['perfumes'] as List)
          .map((e) => PerfumeSimple.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'SearchResponse{brands: $brands, perfumes: $perfumes}';
  }

  @override
  List<Object?> get props => [if (brands != null) brands, if (perfumes != null) perfumes];
}
