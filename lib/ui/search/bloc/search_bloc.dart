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
          type: 'ALL',
          status: SearchStatus.ready,
        )) {
    on<SearchReset>(_onSearchReset);
    on<SearchTypeChanged>(_onSearchTypeChanged);
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
      type: "ALL",
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
    final searchResponse = await _searchRepository.search(
      keyword: event.keyword,
      type: state.type,
    );
    emit(state.copyWith(
      keyword: event.keyword,
      status: SearchStatus.success,
      result: searchResponse,
    ));
  }

  /// 탭 변경시 검색 타입도 변경
  Future<void> _onSearchTypeChanged(
    SearchTypeChanged event,
    Emitter<SearchState> emit,
  ) async {
    print('_onSearchTypeChanged. event: $event, state: $state');
    if (state.status == SearchStatus.success ||
        state.status == SearchStatus.failure) {
      emit(state.copyWith(
        type: event.type,
        status: SearchStatus.inProgress,
      ));
      final searchResponse = await _searchRepository.search(
        keyword: state.keyword,
        type: event.type,
      );
      emit(state.copyWith(
        type: event.type,
        status: SearchStatus.success,
        result: searchResponse,
      ));
    }
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
