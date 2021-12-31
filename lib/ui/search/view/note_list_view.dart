import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/adapter/api/model/note_simple.dart';
import 'package:digging/domain/note_group.dart';
import 'package:digging/ui/linear_loading_view.dart';
import 'package:digging/ui/search/view/search_perfume_list_view.dart';
import 'package:flutter/material.dart';

import '/domain/note.dart';

/// 검색화면에서 노트그룹 누르면 노트 목록 나오는 화면
class NoteListView extends StatefulWidget {
  final NoteGroup noteGroup;

  NoteListView({required this.noteGroup});

  @override
  State<StatefulWidget> createState() => _NoteListView(noteGroup);
}

class _NoteListView extends State<NoteListView> {
  final NoteGroup _noteGroup;
  final DiggingApi _api = DiggingApi();

  _NoteListView(this._noteGroup);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _api.fetchNotes(_noteGroup.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearLoadingView();
        }
        List<Note> notes = (snapshot.data as List<NoteSimple>)
            .map((e) => Note(e.id, e.name))
            .toList();
        return Scaffold(
          appBar: _appBar(),
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
                                    _noteGroup.assetImageName,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  _noteGroup.name,
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
                            _noteGroup.description,
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
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text(
        _noteGroup.name,
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
    );
  }

  /// 노트 리스트 아이템 위젯 생성
  Widget toNoteWidget(BuildContext context, Note note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          _goToPerfumeDetailView(context, note);
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
  void _goToPerfumeDetailView(context, Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPerfumeListView(note: note),
      ),
    );
  }
}
