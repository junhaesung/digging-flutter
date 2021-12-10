import 'package:flutter/material.dart';

import 'ui/SplashView.dart';
import 'ui/main/MainPerfumeListView.dart';
import 'ui/main/MainView.dart';
import 'ui/onboard/DescriptionView.dart';
import 'ui/onboard/GenderAndAgeView.dart';
import 'ui/onboard/NicknameView.dart';
import 'ui/onboard/NoteGroupView.dart';
import 'ui/perfume/PerfumeDetailView.dart';
import 'ui/search/SearchView.dart';

void main() {
  runApp(DiggingApp());
}

class DiggingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashView(),
        '/main': (context) => MainView(),
        '/main/perfumes': (context) => MainPerfumeListView(),
        '/perfume/detail': (context) => PerfumeDetailView(),
        '/search': (context) => SearchView(),
        '/onboard/description': (context) => DescriptionView(),
        '/onboard/nickname': (context) => NicknameView(),
        '/onboard/gender-and-age': (context) => GenderAndAgeView(),
        '/onboard/note-group': (context) => NoteGroupView(),
      },
    );
  }
}
