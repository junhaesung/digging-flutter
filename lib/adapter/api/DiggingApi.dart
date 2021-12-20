import 'dart:convert';

import 'package:digging/adapter/api/model/LoginRequest.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/adapter/storage/secure_storage_api.dart';
import 'package:http/http.dart' as http;

import 'model/ApiResponse.dart';
import 'model/BrandDetail.dart';
import 'model/LoginResponse.dart';
import 'model/NoteSimple.dart';
import 'model/PerfumeDetail.dart';

class DiggingApi {
  final TokenStorage _tokenStorage = TokenStorage();
  final String _host = "api.digging.me";

  Future<LoginResponse> login(String uuid) async {
    final loginRequest = LoginRequest(
      idProviderType: IdProviderType.UUID,
      idProviderUserId: uuid,
    );
    return http
        .post(
          Uri.http(_host, '/api/v1/members/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(loginRequest.toMap()),
        )
        .then((value) => json.decode(value.body))
        .then((value) => ApiResponse.loginData(value))
        .then((value) => value.data!);
  }

  Future<BrandDetail> fetchBrand(int brandId) async {
    final accessToken = await _getAccessToken();
    return http
        .get(
          Uri.http(_host, '/api/v1/brands/$brandId'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => ApiResponse.brandData(json.decode(value.body)))
        .then((value) => value.data!.brandDetail);
  }

  Future<PerfumeDetail> fetchPerfume(int perfumeId) async {
    final accessToken = await _getAccessToken();
    return http
        .get(
          Uri.http(_host, '/api/v1/perfumes/$perfumeId'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => ApiResponse.perfumeData(json.decode(value.body)))
        .then((value) => value.data!.perfumeDetail);
  }

  Future<List<PerfumeSimple>> fetchPerfumes(int noteId) async {
    final accessToken = await _getAccessToken();
    return http
        .get(
          Uri.http(_host, '/api/v1/perfumes', {'noteId': noteId.toString()}),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => ApiResponse.perfumesData(json.decode(value.body)))
        .then((value) => value.data!.perfumeSimples);
  }

  Future<List<NoteSimple>> fetchNotes(int noteGroupId) async {
    final accessToken = await _getAccessToken();
    return http
        .get(
          Uri.http(_host, '/api/v1/note-groups/$noteGroupId/notes'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => ApiResponse.notesData(json.decode(value.body)))
        .then((value) => value.data!.noteSimples);
  }

  Future<String?> _getAccessToken() async {
    return _tokenStorage.read();
  }
}
