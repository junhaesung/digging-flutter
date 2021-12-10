import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('images/splash_background.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: getDescriptionWidget(),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/onboard/nickname');
        },
        child: Text("다음"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget getDescriptionWidget() {
    return Column(
      children: [
        Container(
          height: 100,
          child: Image.asset('images/logo.png'),
        ),
        Text('나를 채워가는\n향수를 발견하다'),
        Text('향수 노트로 향수 찾기를 시작하세요.\nLet’s Start digging!'),
      ],
    );
  }
}
