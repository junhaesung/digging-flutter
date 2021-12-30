import 'dart:async';

import 'package:digging/adapter/api/digging_api.dart';

class NicknameRepository {
  final DiggingApi _api = DiggingApi();

  Future<ErrorCode?> update({
    required String nickname,
  }) async {
    return await _api.update(nickname: nickname);
  }
}
