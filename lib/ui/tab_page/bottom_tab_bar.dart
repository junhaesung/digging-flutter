import 'package:digging/ui/design/digging_color.dart';
import 'package:digging/ui/tab_page/tab_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) {
        return BottomNavigationBar(
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
          selectedItemColor: DiggingColor.black,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(state.index == 0
                    ? 'images/icon/bottom_home_selected.png'
                    : 'images/icon/bottom_home.png',),
                size: 20,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(state.index == 1
                    ? 'images/icon/bottom_search_selected.png'
                    : 'images/icon/bottom_search.png'),
                size: 20,
              ),
              label: 'search',
            ),
            // TODO: digging view
          ],
        );
      },
    );
  }
}
