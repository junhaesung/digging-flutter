import 'brand_detail.dart';

class BrandData {
  BrandDetail brandDetail;

  BrandData(this.brandDetail);

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
        BrandDetail.fromJson(json['brand'])
    );
  }
}