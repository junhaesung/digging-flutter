import 'package:flutter/material.dart';

class SearchResultEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.error_outline),
        Text('검색 결과가 없습니다. \n다른 검색어로 검색해보세요.'),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text('이름, 브랜드를 영어로 입력해주세요.'),
          ),
        ),
      ],
    );
  }
}
