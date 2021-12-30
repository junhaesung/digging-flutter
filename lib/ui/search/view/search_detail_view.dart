import 'package:digging/ui/search/bloc/search_bloc.dart';
import 'package:digging/ui/search/tab/search_tab_navigator.dart';
import 'package:digging/ui/search/view/search_detail_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDetailView extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => SearchDetailView());
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getSearchBar(context),
                SearchDetailTabView(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [],
                    ),
                    child: SearchTabNavigator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSearchBar(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final searchBloc = context.read<SearchBloc>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '향수 이름, 브랜드 영문 입력',
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: _controller.clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onSubmitted: (value) {
                    print('onSubmitted: $value');
                    searchBloc.add(SearchKeywordSubmitted(keyword: value));
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  searchBloc.add(SearchReset());
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
            ],
          ),
        );
      },
    );
  }
}
