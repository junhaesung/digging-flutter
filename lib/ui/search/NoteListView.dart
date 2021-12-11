import 'package:digging/domain/notegroup.dart';
import 'package:flutter/material.dart';

import '/domain/note.dart';

/// 검색화면에서 노트그룹 누르면 노트 목록 나오는 화면
class NoteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteListView();
}

class _NoteListView extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    Map<String, Object>? arguments =
        (ModalRoute.of(context)!.settings).arguments as Map<String, Object>?;
    NoteGroup noteGroup = arguments != null && arguments.containsKey('noteGroup')
        ? arguments['noteGroup'] as NoteGroup
        : NoteGroup.getNoteGroups()[0];
    List<Note> notes = arguments != null && arguments.containsKey('notes')
        ? arguments['notes'] as List<Note>
        : Note.getNotes(10);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          noteGroup.name,
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
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 32,
                              child: Image.asset(
                                noteGroup.assetImageName,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              noteGroup.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff11171c),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 15),
                      Text(
                        noteGroup.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff11171c),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 28),
                Expanded(
                  child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    children:
                        notes.map((e) => toNoteWidget(context, e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 노트 리스트 아이템 위젯 생성
  Widget toNoteWidget(BuildContext context, Note note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          _goToPerfumeDetailView(context);
        },
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
      ),
    );
  }

  /// 향수 목록 화면으로 이동
  void _goToPerfumeDetailView(context) {
    Navigator.pushNamed(context, '/search/perfumes');
  }
}
