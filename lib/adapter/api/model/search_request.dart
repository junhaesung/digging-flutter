class SearchRequest {
  const SearchRequest({
    required this.name,
    required this.type,
    this.page = 0,
    this.size = 20,
  });

  final String name;
  final String type;
  final int page;
  final int size;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'page': page,
      'size': size,
    };
  }

  @override
  String toString() {
    return 'SearchRequest{name: $name, type: $type, page: $page, size: $size}';
  }
}
