part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.keyword,
    required this.type,
    required this.status,
    this.result,
  });

  final String keyword;
  final String type;
  final SearchStatus status;
  final Object? result;

  SearchState copyWith({
    String? keyword,
    String? type,
    SearchStatus? status,
    Object? result,
  }) {
    print('copyWith. keyword: $keyword, status: $status, result: $result');
    var searchState = SearchState(
      keyword: keyword ?? this.keyword,
      type: type ?? this.type,
      status: status ?? this.status,
      result: result ?? this.result,
    );
    print('copyWith. searchState: $searchState');
    return searchState;
  }

  @override
  List<Object> get props => [keyword, type, status, if (result != null) result!];

  @override
  String toString() {
    return 'SearchState{keyword: $keyword, status: $status, result: $result}';
  }
}
