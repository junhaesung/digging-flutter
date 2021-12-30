import 'package:digging/ui/design/digging_color.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';

class OnboardDotsIndicator extends StatelessWidget {
  const OnboardDotsIndicator({required double position}) : _position = position;
  final double _position;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      position: _position,
      decorator: DotsDecorator(
        color: DiggingColor.grey,
        activeColor: DiggingColor.skyBlue,
      ),
    );
  }
}
