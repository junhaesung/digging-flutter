import 'package:digging/ui/search/bloc/search_bloc.dart';
import 'package:digging/ui/search/tab/search_tab_cubit.dart';
import 'package:digging/ui/search/view/result/search_result_all.dart';
import 'package:digging/ui/search/view/result/search_result_brand.dart';
import 'package:digging/ui/search/view/result/search_result_perfume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTabCubit, SearchTabState>(
      builder: (context, state) => BlocBuilder<SearchBloc, SearchState>(
        builder: (context, _) => Navigator(
          pages: _getPages(state),
          onPopPage: (route, result) => route.didPop(result),
        ),
      ),
    );
  }

  List<Page<dynamic>> _getPages(SearchTabState state) {
    return [
      if (state.isAll) MaterialPage(child: SearchResultAll()),
      if (state.isBrand) MaterialPage(child: SearchResultBrand()),
      if (state.isPerfume) MaterialPage(child: SearchResultPerfume()),
    ];
  }
}
