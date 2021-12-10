import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class NoteGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe5e5e5),
        elevation: 0.0,
        title: DotsIndicator(dotsCount: 3, position: 2),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: api 요청
              // 메인페이지 이동
              goToMainView(context);
            },
            child: Text('건너뛰기'),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffe5e5e5),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text('좋아하는\n향수 노트를 알고싶어요.'),
                Text('취향을 선택하고 나에게 맞는 향수를 찾아보세요.'),
                Text('최대 3가지 선택'),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 162 / 104,
                    children: getNoteGroupWidgets(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          goToMainView(context);
        },
        child: Text('선택 완료'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );

  List<Widget> getNoteGroupWidgets() => [
      'CITRUS SMELLS',
      'FRUITS & VEGETABLES',
      'FLOWERS',
      'WHITE FLOWERS',
      'GREENS',
      'SPICES',
      'SWEETS & GOURMAND',
      'WOODS',
      'RESINS & BALSMAS',
      'ANIMALIC',
      'BEVERAGES',
      'NATURAL & SYNTHETIC',
    ]
        .map((e) => Text(e))
        .map((e) => TextButton(onPressed: () {}, child: e))
        .map((e) => Container(
              child: e,
              color: Colors.grey,
            ))
        .map((e) => Padding(padding: EdgeInsets.all(6), child: e))
        .toList();

  goToMainView(BuildContext context) {
    while(Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacementNamed(context, '/main');
  }
}
