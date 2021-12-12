import 'BrandDetail.dart';

class BrandData {
  BrandDetail brandDetail;

  BrandData(this.brandDetail);

  factory BrandData.fromJson(Map<String, dynamic> json) {
    print("BrandData.fromJson: " + json.toString());
    return BrandData(
        BrandDetail.fromJson(json['brand'])
    );
  }
}