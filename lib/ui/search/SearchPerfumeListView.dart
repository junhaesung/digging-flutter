import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/domain/note.dart';
import 'package:digging/domain/perfume.dart';
import 'package:digging/ui/perfume/PerfumeDetailView.dart';
import 'package:flutter/material.dart';

class SearchPerfumeListView extends StatefulWidget {
  final Note note;

  SearchPerfumeListView({required this.note});

  @override
  State<StatefulWidget> createState() => _SearchPerfumeListView(this.note);
}

class _SearchPerfumeListView extends State<SearchPerfumeListView> {
  final Note _note;
  final DiggingApi api = DiggingApi();

  _SearchPerfumeListView(this._note);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fetchPerfumes(_note.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: _getAppBarWidget(),
            body: LinearProgressIndicator(),
          );
        }
        List<Perfume> perfumes = (snapshot.data as List<PerfumeSimple>)
            .map((e) => _toPerfume(e))
            .toList();
        return Scaffold(
          appBar: _getAppBarWidget(),
          body: SafeArea(
            child: Container(
              color: Color(0xfff8f8f8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.0),
                            child: Container(
                              color: Color(0xfffffcef),
                              child: Text(
                                _note.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xfffbd857),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 162 / 231,
                        children: perfumes
                            .map((e) => _toPerfumeWidget(context, e))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toPerfumeWidget(
    BuildContext context,
    Perfume perfume,
  ) {
    return GestureDetector(
      onTap: () {
        _goToPerfumeDetailView(context, perfume);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.white,
                  height: 163,
                  child: Image.network(perfume.imageUrl),
                ),
              ),
            ),
            Text(
              perfume.brandName,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff888888),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              perfume.name,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff11171c),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _goToPerfumeDetailView(
    BuildContext context,
    Perfume perfume,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PerfumeDetailView(perfumeId: perfume.id),
      ),
    );
  }

  Perfume _toPerfume(PerfumeSimple perfumeSimple) {
    return Perfume(
      perfumeSimple.id,
      perfumeSimple.name,
      perfumeSimple.brandName,
      perfumeSimple.thumbnailImageUrl,
    );
  }

  PreferredSizeWidget _getAppBarWidget() => AppBar(
      title: Text(
        _note.name,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff1b1b1b),
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Color(0xfff8f8f8),
      toolbarHeight: 44,
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
