import 'package:digging/auth/auth.dart';
import 'package:digging/session/bloc/session_bloc.dart';
import 'package:digging/ui/app_navigator.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/onboard/age_group/age_group.dart';
import 'ui/onboard/gender/gender.dart';
import 'ui/onboard/note_group/note_group.dart';
import 'ui/search/SearchView.dart';

class DiggingApp extends StatelessWidget {
  DiggingApp({
    required this.onboardRepository,
    required this.authRepository,
  });

  final OnboardRepository onboardRepository;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (_) => onboardRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GenderBloc>(
            create: (_) => GenderBloc(),
          ),
          BlocProvider<AgeGroupBloc>(
            create: (_) => AgeGroupBloc(),
          ),
          BlocProvider<NoteGroupBloc>(
            create: (_) => NoteGroupBloc(),
          ),
          BlocProvider<SessionBloc>(
            create: (_) => SessionBloc(
              authRepository: authRepository,
            ),
          ),
        ],
        child: BlocProvider<OnboardBloc>(
          create: (context) {
            return OnboardBloc(
              onboardRepository: onboardRepository,
              sessionBloc: context.read<SessionBloc>(),
            );
          },
          child: MaterialApp(
            home: AppNavigator(),
            routes: {
              '/search': (context) => SearchView(),
            },
          ),
        ),
      ),
    );
  }
}
