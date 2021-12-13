import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/ApiResponse.dart';
import 'model/BrandDetail.dart';
import 'model/PerfumeDetail.dart';

class DiggingApi {
  String _host = "http://api.digging.me";
  String _accessToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhY20tYXBpLWRldmVsb3AiLCJtZW1iZXJJZCI6MjExNzd9.sQta6Xokjdoc7Bt_KaLVYxMX8nBhqDdJvbqRX5eErms';

  Future<BrandDetail> fetchBrand(int brandId) async {
    return http
        .get(Uri.parse('$_host/api/v1/brands/$brandId'),
            headers: {'Authorization': 'Bearer $_accessToken'})
        .then((value) => ApiResponse.brandData(json.decode(value.body)))
        .then((value) => value.data!.brandDetail);
  }

  Future<PerfumeDetail> fetchPerfume(int perfumeId) async {
    return http
        .get(Uri.parse('$_host/api/v1/perfumes/$perfumeId'),
        headers: {'Authorization': 'Bearer $_accessToken'})
        .then((value) => ApiResponse.perfumeData(json.decode(value.body)))
        .then((value) => value.data!.perfumeDetail);
  }
}

