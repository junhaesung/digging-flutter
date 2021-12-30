import 'package:digging/auth/auth.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:digging/ui/search/repository/repository.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'ui/onboard/nickname/repository/repository.dart';

void main() {
  runApp(
    DiggingApp(
      onboardRepository: OnboardRepository(),
      authRepository: AuthRepository(),
      searchRepository: SearchRepository(),
      nicknameRepository: NicknameRepository(),
    ),
  );
}
