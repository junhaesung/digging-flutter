import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tab_state.dart';

class SearchTabCubit extends Cubit<SearchTabState> {
  SearchTabCubit() : super(SearchTabState(type: SearchTabStateType.all));

  void showTab(SearchTabStateType type) {
    if (state.type != type) {
      emit(state.copyWith(type: type));
    }
  }
}