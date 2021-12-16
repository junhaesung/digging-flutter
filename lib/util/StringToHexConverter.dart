import 'package:flutter/cupertino.dart';

class StringToHexConverter {
  StringToHexConverter._();

  // #1abcde -> 0xff1abcde
  static toHex(String colorString) {
    return int.parse('ff${colorString.substring(1, 7)}', radix: 16);
  }
}