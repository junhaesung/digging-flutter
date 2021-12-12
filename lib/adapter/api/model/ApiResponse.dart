import 'package:digging/adapter/api/model/BrandDetail.dart';

import 'BrandData.dart';

class ApiResponse<T> {
  String code;
  String message;
  T? data;

  ApiResponse(this.code, this.message, this.data);

  static ApiResponse<BrandData> brandData(Map<String, dynamic> json) {
    print("ApiResponse.fromJson: " + json.toString());
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      BrandData.fromJson(json['data']),
    );
  }
}
