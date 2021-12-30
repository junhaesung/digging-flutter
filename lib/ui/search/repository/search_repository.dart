import 'dart:async';

import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/adapter/api/model/search_response.dart';

class SearchRepository {
  final _api = const DiggingApi();
  final _controller = StreamController<SearchStatus>();

  Stream<SearchStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield SearchStatus.ready;
    yield* _controller.stream;
  }

  Future<SearchResponse?> search({
    required String keyword,
    required String type,
  }) async {
    _controller.add(SearchStatus.inProgress);
    try {
      final searchResponse = await _api.search(
        keyword: keyword,
        type: type,
      );
      print('response: $searchResponse');
      print('response.brands.length: ${searchResponse.brands?.length}');
      print('response.perfumes.length: ${searchResponse.perfumes?.length}');
      return searchResponse;
    } catch (e) {
      print('Failed to search api. $e');
      _controller.add(SearchStatus.failure);
      return null;
    }
  }

  Future<void> dispose() async {
    _controller.close();
  }
}

enum SearchStatus {
  ready,
  inProgress,
  success,
  failure,
}
