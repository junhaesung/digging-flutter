import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getDescriptionWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingActionButtonWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _getDescriptionWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image.asset(
              'images/onboarding/background_description.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나를 채워가는\n향수를 발견하다',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1b1b1b),
                  ),
                ),
                Container(height: 20),
                Text(
                  '향수 노트로 향수 찾기를 시작하세요.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff1b1b1b),
                  ),
                ),
                Container(height: 4),
                Text(
                  'Let’s Start digging!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff1b1b1b),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _floatingActionButtonWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/onboard/nickname');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
      ),
      child: Container(
        height: 52,
        width: 340,
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
    );
  }
}
