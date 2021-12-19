import 'package:digging/adapter/storage/secure_storage_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = TokenStorage();

  test('토큰 조회', () async {
    final actual = await sut.read();
    print(actual);
  });
}