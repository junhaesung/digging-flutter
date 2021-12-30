part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/// 검색 api 상태 변경 (ready, processing, completed(success, failure))
class SearchStatusChanged extends SearchEvent {
  const SearchStatusChanged({required this.status});

  final SearchStatus status;

  @override
  List<Object> get props => [status];

  @override
  String toString() {
    return 'SearchStatusChanged{status: $status}';
  }
}

/// 취소버튼 누르고 검색페이지 나감
class SearchReset extends SearchEvent {
  const SearchReset();
}

class SearchTypeChanged extends SearchEvent {
  const SearchTypeChanged({required this.type});

  final String type;
}

/// 검색어 제출함
class SearchKeywordSubmitted extends SearchEvent {
  const SearchKeywordSubmitted({required this.keyword});

  final String keyword;

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchKeywordSubmitted{keyword: $keyword}';
  }
}

/// 검색결과
class SearchResult extends SearchEvent {
  const SearchResult();
}
