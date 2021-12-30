import 'dart:ui';

class StringColorConverter {
  StringColorConverter._();

  // #1abcde -> 0xff1abcde
  static toHex(String colorString) {
    return int.parse('ff${colorString.substring(1, 7)}', radix: 16);
  }

  static toColor(String colorString) {
    return Color(toHex(colorString));
  }
}