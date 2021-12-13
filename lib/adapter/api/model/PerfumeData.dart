import 'PerfumeDetail.dart';

class PerfumeData {
  PerfumeDetail perfumeDetail;

  PerfumeData(this.perfumeDetail);

  factory PerfumeData.fromJson(Map<String, dynamic> json) {
    return PerfumeData(
        PerfumeDetail.fromJson(json['perfumeDetail'])
    );
  }
}