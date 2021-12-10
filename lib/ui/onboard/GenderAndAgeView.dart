import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class GenderAndAgeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe5e5e5),
        elevation: 0.0,
        title: DotsIndicator(dotsCount: 3, position: 1),
        actions: [
          TextButton(
            onPressed: () {
              goToNoteGroupView(context);
            },
            child: Text('건너뛰기'),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffe5e5e5),
          child: Column(
            children: [
              Text(
                '성별과 \n나이를 선택해주세요.',
                style: TextStyle(fontSize: 20),
              ),
              Text('성별'),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('여성'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('남성'),
                  ),
                ],
              ),
              Text('나이'),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('10대'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('20대'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('30대'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('40대'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('50대'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          goToNoteGroupView(context);
        },
        child: Text('다음'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  goToNoteGroupView(BuildContext context) {
    Navigator.pushNamed(context, '/onboard/note-group');
  }
}
