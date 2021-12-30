import 'package:digging/adapter/api/digging_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DiggingApi sut = DiggingApi();

  test('login', () async {
    final actual = await sut.login("uuid");
    print(actual);
  });

  // test('updateNickname', () async {
  //   final login = await sut.login("uuid");
  //   final actual = await sut.update("nickname");
  //   print(actual == null);
  // });
}