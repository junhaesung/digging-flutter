import 'package:digging/ui/main/main_view.dart';
import 'package:digging/ui/search/view/SearchView.dart';
import 'package:digging/ui/tab_page/tab_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPageNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) => Navigator(
        pages: _getPages(state),
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }

  List<Page<dynamic>> _getPages(TabPageState state) {
    return [
      if (state == TabPageState.main) MaterialPage(child: MainView()),
      if (state == TabPageState.search) MaterialPage(child: SearchView()),
    ];
  }
}
