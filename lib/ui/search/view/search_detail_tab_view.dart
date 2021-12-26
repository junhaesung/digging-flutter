import 'package:digging/ui/search/tab/search_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDetailTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabItems = [
      _TabItem(title: '전체'),
      _TabItem(title: '브랜드'),
      _TabItem(title: '제품'),
    ];
    return BlocBuilder<SearchTabCubit, SearchTabState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) => DefaultTabController(
        length: tabItems.length,
        child: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4.0,
              color: Color(0xff83daff),
            ),
          ),
          tabs: tabItems,
          onTap: (index) {
            context.read<SearchTabCubit>()
                .showTab(SearchTabStateType.values[index]);
          },
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20,
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xff1b1b1b),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
