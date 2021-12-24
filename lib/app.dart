import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nickname/nickname.dart';
import 'ui/onboard/DescriptionView.dart';
import 'ui/onboard/NicknameView.dart';
import 'ui/onboard/NoteGroupView.dart';
import 'ui/search/SearchView.dart';
import 'ui/splash/SplashView.dart';

class DiggingApp extends StatelessWidget {
  final NicknameRepository nicknameRepository;

  DiggingApp({required this.nicknameRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: nicknameRepository,
      child: BlocProvider(
        create: (_) => NicknameBloc(
          nicknameRepository: RepositoryProvider.of<NicknameRepository>(context),
        ),
        child: MaterialApp(
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashView(),
            '/search': (context) => SearchView(),
            '/onboard/description': (context) => DescriptionView(),
            '/onboard/nickname': (context) => NicknameView(),
            '/onboard/note-group': (context) => NoteGroupView(),
          },
        ),
      ),
    );
  }
}
