import 'package:digging/domain/note.dart';
import 'package:digging/ui/main/MainView.dart';
import 'package:digging/ui/search/NoteListView.dart';
import 'package:flutter/material.dart';

import '/domain/notegroup.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "검색",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff11171c),
          ),
        ),
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: Color(0xfff8f8f8),
      ),
      body: Container(
        color: Color(0xfff8f8f8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  height: 44,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Icon(Icons.search, size: 20),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '  향수 이름, 브랜드 영문 입력',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffc7c7c7),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 20,
                    ),
                    child: Container(
                      child: Text(
                        '노트로 향수 찾기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff11171c),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Container(
                        child: GridView.count(
                          // physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 164 / 104,
                          children: NoteGroup.getNoteGroups()
                              .map((e) => toNoteGroupWidget(context, e))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        ],
      );

  void goToMainView(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MainView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  void goToNoteListView(
    BuildContext context,
    NoteGroup noteGroup,
    List<Note> notes,
  ) {
    Navigator.pushNamed(context, '/search/notes', arguments: {
      "notes": notes,
      "noteGroup": noteGroup,
    });
  }

  Widget toNoteGroupWidget(BuildContext context, NoteGroup noteGroup) {
    var notes = Note.getNotes(10);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          goToNoteListView(
            context,
            noteGroup,
            notes,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 104,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Image.asset(
                    noteGroup.assetImageName,
                    height: 32,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(height: 10),
                  Text(noteGroup.name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
