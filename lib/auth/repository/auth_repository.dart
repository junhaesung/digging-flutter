import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/MemberDetail.dart';
import 'package:digging/adapter/storage/secure_storage_api.dart';

class AuthRepository {
  const AuthRepository();

  final DiggingApi _api = const DiggingApi();
  final TokenStorage _tokenStorage = const TokenStorage();

  Future<MemberDetail> attemptAutoLogin(String uuid) async {
    final loginResponse = await _api.login(uuid);
    _tokenStorage.write(loginResponse.accessToken);
    return loginResponse.memberDetail;
  }

  Future<void> withdraw() async {
    await _api.withdraw();
    _tokenStorage.delete();
  }
}
