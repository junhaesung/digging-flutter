import 'package:flutter/material.dart';

import 'app.dart';
import 'nickname/nickname.dart';

void main() {
  runApp(DiggingApp(
    nicknameRepository: NicknameRepository(),
  ));
}
