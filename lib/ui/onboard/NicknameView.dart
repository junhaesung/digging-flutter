import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class NicknameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DotsIndicator(dotsCount: 3, position: 0),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xffe5e5e5),
      ),
      body: Container(
        color: Color(0xffe5e5e5),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 32),
                  Text(
                    '사용하실 \n닉네임을 입력하세요',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1d1d20),
                    ),
                  ),
                  Container(height: 28),
                  Container(
                    height: 52,
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
                            fontSize: 16,
                            color: Color(0xffc7c7c7),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingActionButtonWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/onboard/gender-and-age');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
        ),
        child: Container(
          height: 52,
          child: Center(
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
    );
  }
}
