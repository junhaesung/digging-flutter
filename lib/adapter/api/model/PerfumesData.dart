import 'package:digging/adapter/api/model/PerfumeSimple.dart';

class PerfumesData {
  List<PerfumeSimple> perfumeSimples;

  PerfumesData(this.perfumeSimples);

  factory PerfumesData.fromJson(Map<String, dynamic> json) {
    return PerfumesData(
      (json['perfumes'] as List)
          .map((e) => PerfumeSimple.fromJson(e))
          .toList(),
    );
  }
}
