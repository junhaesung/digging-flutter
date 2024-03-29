import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: Container(
        child: Column(
          children: [
            Image.asset('images/splash_background.png'),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fitHeight,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Image.asset('images/splash_background.png'),
            ),
          ],
        ),
      ),
    );
  }
}
