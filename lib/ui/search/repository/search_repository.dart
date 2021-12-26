import 'dart:async';

import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/adapter/api/model/search_response.dart';

class SearchRepository {
  final _api = const DiggingApi();
  final _controller = StreamController<SearchStatus>();

  Stream<SearchStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield SearchStatus.ready;
    yield* _controller.stream;
  }

  Future<SearchResponse?> searchAll(String keyword) async {
    _controller.add(SearchStatus.inProgress);
    try {
      final searchResponse = await _api.searchAll(keyword: keyword);
      print('searchAll. response: $searchResponse');
      print('searchAll. response.brands.length: ${searchResponse.brands?.length}');
      print('searchAll. response.perfumes.length: ${searchResponse.perfumes?.length}');
      return searchResponse;
    } catch (e) {
      print('Failed to search api. $e');
      _controller.add(SearchStatus.failure);
      return null;
    }
  }

  Future<List<BrandSimple>?> searchBrand(String keyword) async {
    _controller.add(SearchStatus.inProgress);
    try {
      final searchResponse = await _api.searchBrand(keyword: keyword);
      _controller.add(SearchStatus.success);
      return searchResponse.brands!;
    } catch (e) {
      print('Failed to search api. $e');
      _controller.add(SearchStatus.failure);
      return null;
    }
  }

  Future<List<PerfumeSimple>?> searchPerfume(String keyword) async {
    _controller.add(SearchStatus.inProgress);
    try {
      final searchResponse = await _api.searchPerfume(keyword: keyword);
      _controller.add(SearchStatus.success);
      _controller.add(SearchStatus.ready);
      return searchResponse.perfumes!;
    } catch (e) {
      print('Failed to search api. $e');
      _controller.add(SearchStatus.failure);
      _controller.add(SearchStatus.ready);
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
