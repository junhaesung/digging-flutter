import 'package:digging/session/bloc/session_bloc.dart';
import 'package:digging/ui/onboard/onboard_navigator.dart';
import 'package:digging/ui/splash/splash_view.dart';
import 'package:digging/ui/tab_page/tab_page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: _getPages(state),
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }

  List<Page<dynamic>> _getPages(SessionState state) {
    final List<Page<dynamic>> pages = [];
    if (state is Unauthenticated || state is Unknown) {
      pages.add(MaterialPage(child: SplashView()));
    }
    if (state is Associate) {
      pages.add(MaterialPage(child: OnboardNavigator()));
    }
    if (state is Authenticated) {
      pages.add(MaterialPage(child: TabPageNavigator()));
    }
    return pages.toList();
  }
}
