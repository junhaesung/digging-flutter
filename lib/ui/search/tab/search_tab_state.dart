part of 'search_tab_cubit.dart';

/// 순서 중요함. tabView 에서 tab 상태 관리할 떄 index 사용함
enum SearchTabStateType {
  all,
  brand,
  perfume,
}

class SearchTabState extends Equatable {
  const SearchTabState({required this.type});

  final SearchTabStateType type;

  SearchTabState copyWith({SearchTabStateType? type}) {
    return SearchTabState(
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [type];

  bool get isAll => type == SearchTabStateType.all;

  bool get isBrand => type == SearchTabStateType.brand;

  bool get isPerfume => type == SearchTabStateType.perfume;
}
