import 'package:digging/ui/design/digging_color.dart';
import 'package:flutter/material.dart';

class SearchResultEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 24,
          color: DiggingColor.grey200,
        ),
        Container(height: 12),
        Text(
          '검색 결과가 없습니다. ',
          style: _textStyle(),
        ),
        Text(
          '다른 검색어로 검색해보세요.',
          style: _textStyle(),
        ),
        Container(height: 28),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.white,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 9.0, horizontal: 24.0),
            child: Text('※  이름, 브랜드를 영어로 입력해주세요.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: DiggingColor.grey200,
              fontSize: 12,
            ),),
          ),
        ),
      ],
    );
  }

  _textStyle() => TextStyle(
        color: DiggingColor.grey200,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      );
}
