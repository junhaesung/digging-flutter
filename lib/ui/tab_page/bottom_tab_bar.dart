import 'package:digging/ui/tab_page/tab_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) => BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: state.index,
        onTap: (index) {
          if (index == 0) {
            context.read<TabPageCubit>().showMainPage();
          }
          if (index == 1) {
            context.read<TabPageCubit>().showSearchPage();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          // TODO: digging view
        ],
      ),
    );
  }
}
