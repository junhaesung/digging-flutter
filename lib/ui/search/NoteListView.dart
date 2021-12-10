import 'package:flutter/material.dart';

import '/domain/note.dart';

/// 검색화면에서 노트그룹 누르면 노트 목록 나오는 화면
class NoteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '노트 그룹 이름',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff1b1b1b),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 44,
        elevation: 0.0,
        backgroundColor: Color(0xfff8f8f8),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff1b1b1b),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xfff8f8f8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  height: 14,
                ),
                Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('image'),
                          Text(
                            'CITRUS',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff11171c),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 15),
                      Text(
                        '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff11171c),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    children: Note.getNotes(10)
                        .map((e) => toNoteWidget(context, e))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget toNoteWidget(BuildContext context, Note note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 18,
            ),
            child: Text(
              note.name,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff11171c),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
