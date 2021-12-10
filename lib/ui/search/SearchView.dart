import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("search view"),
      bottomNavigationBar: getBottomNavigationBar(context),
    );
  }

  BottomNavigationBar getBottomNavigationBar(BuildContext context) =>
      BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            goToMainView(context);
          }
          if (index == 1) {
            // do nothing
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          // TODO: digging view
        ],
      );

  void goToMainView(BuildContext context) {
    Navigator.pushNamed(context, '/main');
  }
}
