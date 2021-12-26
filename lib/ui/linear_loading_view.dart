import 'package:flutter/material.dart';

class LinearLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        elevation: 0.0,
        backgroundColor: Color(0xfff8f8f8),
      ),
      body: LinearProgressIndicator(),
    );
  }

}