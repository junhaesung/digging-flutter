import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DiggingApi sut = DiggingApi();

  test('login', () async {
    final actual = await sut.login("uuid");
    print(actual);
  });
}