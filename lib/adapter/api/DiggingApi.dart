import 'dart:convert';

import 'package:digging/adapter/api/model/LoginRequest.dart';
import 'package:digging/adapter/api/model/MemberDetail.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/adapter/api/model/UpdateNicknameRequest.dart';
import 'package:digging/adapter/storage/secure_storage_api.dart';
import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:http/http.dart' as http;

import 'model/ApiResponse.dart';
import 'model/BrandDetail.dart';
import 'model/LoginResponse.dart';
import 'model/NoteSimple.dart';
import 'model/PerfumeDetail.dart';
import 'model/initialize_request.dart';

class DiggingApi {
  const DiggingApi();

  final TokenStorage _tokenStorage = const TokenStorage();

  final String _host = "api.digging.me";

  /// 로그인
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

  /// 내 정보 조회
  Future<MemberDetail> fetchMyInfo() async {
    final accessToken = await _getAccessToken();
    return http
        .get(
          Uri.http(_host, '/api/v1/members/me'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        )
        .then((value) => json.decode(value.body))
        .then((value) => ApiResponse.memberData(value))
        .then((value) => value.data!.memberDetail);
  }

  /// 닉네임 수정
  Future<ErrorCode?> update({required String nickname}) async {
    final accessToken = await _getAccessToken();
    final updateNicknameRequest = UpdateNicknameRequest(nickname);
    return http
        .put(
          Uri.http(_host, '/api/v1/members/me/nickname'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: json.encode(updateNicknameRequest.toMap()),
        )
        .then((value) => json.decode(value.body))
        .then((value) => ApiResponse.emptyData(value))
        .then((value) => ErrorCodes.valueOf(value.code));
  }

  /// 멤버 온보딩 정보 제출 및 상태 변경
  Future<ErrorCode?> initialize(
    Gender gender,
    AgeGroup ageGroup,
    NoteGroupIds noteGroupIds,
  ) async {
    final accessToken = await _getAccessToken();
    final initializeRequest = InitializeRequest(
      gender: gender,
      ageGroup: ageGroup,
      noteGroupIds: noteGroupIds,
    );
    http
        .post(
          Uri.http(_host, '/api/v1/members/initialize'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: json.encode(initializeRequest.toMap()),
        )
        .then((value) => json.decode(value.body))
        .then((value) => ApiResponse.emptyData(value))
        .then((value) => ErrorCodes.valueOf(value.code));
  }

  /// 회원 탈퇴
  Future<ErrorCode?> withdraw() async {
    final accessToken = await _getAccessToken();
    return http
        .post(
          Uri.http(_host, '/api/v1/members/withdraw'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        )
        .then((value) => json.decode(value.body))
        .then((value) => ApiResponse.emptyData(value))
        .then((value) => ErrorCodes.valueOf(value.code))
        .catchError((e) {
          print('Failed to request api. $e');
          return ErrorCode.FAILURE;
        });
  }

  /// 브랜드 상세 조회
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

  /// 향수 상세 조회
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

  /// 향수 목록 조회
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

  /// 노트 목록 조회
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
    return await _tokenStorage.read();
  }
}

enum ErrorCode {
  SUCCESS,
  FAILURE,
  MEMBER_NICKNAME_ALREADY_EXIST,
}

extension ErrorCodes on ErrorCode {
  static ErrorCode? valueOf(String value) {
    switch (value) {
      case "SUCCESS":
        return null;
      case "FAILURE":
        return ErrorCode.FAILURE;
      case "MEMBER_NICKNAME_ALREADY_EXIST":
        return ErrorCode.MEMBER_NICKNAME_ALREADY_EXIST;
      default:
        print('Failed to request api with unknown error. code: $value');
        return ErrorCode.FAILURE;
    }
  }
}
