import 'package:digging/adapter/api/model/search_response.dart';
import 'package:digging/ui/search/bloc/search_bloc.dart';
import 'package:digging/ui/search/repository/repository.dart';
import 'package:digging/ui/search/view/result/item/search_result_perfume_item.dart';
import 'package:digging/ui/search/view/result/search_result_empty.dart';
import 'package:digging/ui/search/view/result/search_result_loading.dart';
import 'package:digging/ui/search/view/result/search_result_ready.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultPerfume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == SearchStatus.ready) {
          return SearchResultReady();
        } else if (state.status == SearchStatus.inProgress) {
          return SearchResultLoading();
        } else if (state.status == SearchStatus.failure) {
          // TODO: error handling
        }
        if (state.result == null) {
          return SearchResultEmpty();
        }
        // SearchStatus.success
        final perfumes = (state.result as SearchResponse).perfumes;
        final isEmpty = perfumes == null || perfumes.isEmpty == true;
        if (isEmpty) {
          return SearchResultEmpty();
        }
        return SingleChildScrollView(
          child: Column(
            children: perfumes!
                .map((e) => SearchResultPerfumeItem(perfume: e))
                .toList(),
          ),
        );
      },
    );
  }
}