import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_page_state.dart';

class TabPageCubit extends Cubit<TabPageState> {
  TabPageCubit() : super(TabPageState.main);

  showMainPage() {
    if (state != TabPageState.main) {
      emit(TabPageState.main);
    }
  }

  showSearchPage() {
    if (state != TabPageState.search) {
      emit(TabPageState.search);
    }
  }
}