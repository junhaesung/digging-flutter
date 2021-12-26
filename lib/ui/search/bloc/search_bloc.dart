import 'dart:async';

import 'package:digging/ui/search/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required SearchRepository searchRepository,
  })  : _searchRepository = searchRepository,
        super(SearchState(
          keyword: '',
          status: SearchStatus.ready,
        )) {
    on<SearchReset>(_onSearchReset);
    on<SearchKeywordSubmitted>(_onSearchKeywordSubmitted);
    on<SearchStatusChanged>(_onSearchStatusChanged);
    on<SearchResult>(_onSearchResult);
    _searchStatusSubscription = _searchRepository.status.listen((status) {
      add(SearchStatusChanged(status: status));
    });
  }

  final SearchRepository _searchRepository;
  late StreamSubscription<SearchStatus> _searchStatusSubscription;

  FutureOr<void> _onSearchReset(
    SearchReset event,
    Emitter<SearchState> emit,
  ) async {
    print('_onSearchReset. event: $event, state: $state');
    emit(state.copyWith(
      keyword: '',
      status: SearchStatus.ready,
      result: null,
    ));
  }

  FutureOr<void> _onSearchKeywordSubmitted(
    SearchKeywordSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    print('_onSearchKeywordSubmitted. event: $event, state: $state');
    // on search button pressed

    // api call
    final searchResponse = await _searchRepository.searchAll(event.keyword);
    emit(state.copyWith(
      keyword: event.keyword,
      status: SearchStatus.success,
      result: searchResponse,
    ));
  }

  FutureOr<void> _onSearchStatusChanged(
    SearchStatusChanged event,
    Emitter<SearchState> emit,
  ) async {
    print('_onSearchStatusChanged. event: $event, state: $state');
    // on search status changed (by repository)

    // change state
    switch (event.status) {
      case SearchStatus.ready:
      case SearchStatus.inProgress:
      case SearchStatus.success:
      case SearchStatus.failure:
        if (state.status != event.status) {
          emit(state.copyWith(status: event.status));
        }
        break;
    }
    // or error page
  }

  FutureOr<void> _onSearchResult(
    SearchResult event,
    Emitter<SearchState> emit,
  ) async {
    print('_onSearchResult. event: $event, state: $state');
    // on api call ended
  }

  @override
  Future<void> close() async {
    _searchStatusSubscription.cancel();
    _searchRepository.dispose();
    super.close();
  }
}
