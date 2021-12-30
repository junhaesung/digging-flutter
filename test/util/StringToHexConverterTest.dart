import 'package:digging/util/string_color_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  _test(String input, int output) {
    test('Test: $input -> $output', () {
      final actual = StringColorConverter.toHex(input);
      expect(actual, output);
    });
  }

  group('색 코드 문자열을 16진수 숫자로 변환한다', () {
    final parameterMap = {
      '#000000': 0xff000000,
      '#010101': 0xff010101,
      '#1A1A1A': 0xff1A1A1A,
      '#FFFFFF': 0xffFFFFFF,
    };
    parameterMap.forEach((key, value) {
      _test(key, value);
    });
  });
}