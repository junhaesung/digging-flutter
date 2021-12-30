import 'package:digging/ui/search/bloc/search_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tab_state.dart';

class SearchTabCubit extends Cubit<SearchTabState> {
  SearchTabCubit({required SearchBloc searchBloc})
      : _searchBloc = searchBloc,
        super(SearchTabState(type: SearchTabStateType.all));

  final SearchBloc _searchBloc;

  void showTab(SearchTabStateType type) {
    if (state.type != type) {
      emit(state.copyWith(type: type));
      _searchBloc.add(SearchTypeChanged(
        type: state.type.name(),
      ));
    }
  }
}
