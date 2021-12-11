import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class NicknameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DotsIndicator(dotsCount: 3, position: 0),
        elevation: 0.0,
        backgroundColor: Color(0xffe5e5e5),
      ),
      body: Container(
        color: Color(0xffe5e5e5),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Center(
                      child: Text(
                    '사용하실 \n닉네임을 입력하세요',
                    style: TextStyle(fontSize: 20),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '2자~6자까지 입력이 가능해요.',
                          hintStyle: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/onboard/gender-and-age');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
        ),
        child: Container(
          height: 52,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "다음",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
