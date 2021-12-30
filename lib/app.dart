import 'package:digging/auth/auth.dart';
import 'package:digging/session/bloc/session_bloc.dart';
import 'package:digging/ui/app_navigator.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/nickname/bloc/nickname_bloc.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:digging/ui/search/bloc/search_bloc.dart';
import 'package:digging/ui/search/repository/repository.dart';
import 'package:digging/ui/search/tab/search_tab_cubit.dart';
import 'package:digging/ui/tab_page/tab_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/onboard/age_group/age_group.dart';
import 'ui/onboard/gender/gender.dart';
import 'ui/onboard/nickname/repository/repository.dart';
import 'ui/onboard/note_group/note_group.dart';

class DiggingApp extends StatelessWidget {
  DiggingApp({
    required this.onboardRepository,
    required this.authRepository,
    required this.searchRepository,
    required this.nicknameRepository,
  });

  final OnboardRepository onboardRepository;
  final AuthRepository authRepository;
  final SearchRepository searchRepository;
  final NicknameRepository nicknameRepository;

  @override
  Widget build(BuildContext context) {
    final sessionBloc = SessionBloc(authRepository: authRepository);
    final onboardBloc = OnboardBloc(
      sessionBloc: sessionBloc,
      onboardRepository: onboardRepository,
    );
    final genderBloc = GenderBloc(onboardBloc: onboardBloc);
    final ageGroupBloc = AgeGroupBloc(onboardBloc: onboardBloc);
    final noteGroupBloc = NoteGroupBloc(onboardBloc: onboardBloc);
    final tabPageCubit = TabPageCubit();
    final searchBloc = SearchBloc(searchRepository: searchRepository);
    final searchTabCubit = SearchTabCubit(searchBloc: searchBloc);
    final nicknameBloc = NicknameBloc(nicknameRepository: nicknameRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (_) => onboardRepository,
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => authRepository,
        ),
        RepositoryProvider<SearchRepository>(
          create: (_) => searchRepository,
        ),
        RepositoryProvider<NicknameRepository>(
          create: (_) => nicknameRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SessionBloc>(create: (_) => sessionBloc),
          BlocProvider<OnboardBloc>(create: (_) => onboardBloc),
          BlocProvider<GenderBloc>(create: (_) => genderBloc),
          BlocProvider<AgeGroupBloc>(create: (_) => ageGroupBloc),
          BlocProvider<NoteGroupBloc>(create: (_) => noteGroupBloc),
          BlocProvider<TabPageCubit>(create: (_) => tabPageCubit),
          BlocProvider<SearchBloc>(create: (_) => searchBloc),
          BlocProvider<SearchTabCubit>(create: (_) => searchTabCubit),
          BlocProvider<NicknameBloc>(create: (_) => nicknameBloc)
        ],
        child: MaterialApp(
          home: AppNavigator(),
        ),
      ),
    );
  }
}
