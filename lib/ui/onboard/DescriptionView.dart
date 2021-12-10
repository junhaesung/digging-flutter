import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('description'),
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
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
}
