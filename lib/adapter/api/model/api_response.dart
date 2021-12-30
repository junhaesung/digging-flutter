import 'package:digging/adapter/api/model/member_data.dart';
import 'package:digging/adapter/api/model/search_response.dart';

import 'brand_data.dart';
import 'login_response.dart';
import 'notes_data.dart';
import 'perfume_data.dart';
import 'perfumes_data.dart';

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

  static ApiResponse<SearchResponse> searchData(Map<String, dynamic> json) {
    return ApiResponse(
      json['code'] as String,
      json['message'] as String,
      SearchResponse.fromJson(json['data']),
    );
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}
