import 'package:digging/adapter/api/model/member_data.dart';

import 'BrandData.dart';
import 'LoginResponse.dart';
import 'NotesData.dart';
import 'PerfumeData.dart';
import 'PerfumesData.dart';

class ApiResponse<T> {
  String code;
  String message;
  T? data;

  ApiResponse(this.code, this.message, this.data);

  static ApiResponse emptyData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      null,
    );
  }

  static ApiResponse<MemberData> memberData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      MemberData.fromJson(json['data']),
    );
  }

  static ApiResponse<BrandData> brandData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      BrandData.fromJson(json['data']),
    );
  }

  static ApiResponse<PerfumeData> perfumeData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      PerfumeData.fromJson(json['data']),
    );
  }

  static ApiResponse<PerfumesData> perfumesData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      PerfumesData.fromJson(json['data']),
    );
  }

  static ApiResponse<NotesData> notesData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      NotesData.fromJson(json['data']),
    );
  }

  static ApiResponse<LoginResponse> loginData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      LoginResponse.fromJson(json['data']),
    );
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}
