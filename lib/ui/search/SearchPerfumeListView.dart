import 'package:digging/domain/note.dart';
import 'package:digging/domain/perfume.dart';
import 'package:flutter/material.dart';

class SearchPerfumeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, Object>? arguments =
        (ModalRoute.of(context)!.settings).arguments as Map<String, Object>?;
    Note note = arguments != null && arguments.containsKey('note')
        ? arguments['note'] as Note
        : Note.getNotes(1).first;
    List<Perfume> perfumes = Perfume.getPerfumes(10);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.name,
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
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xfff8f8f8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
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
                            note.name,
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
  }

  Widget _toPerfumeWidget(BuildContext context, Perfume perfume) {
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
    Navigator.pushNamed(
      context,
      '/perfume/detail',
      arguments: {
        "perfume": Perfume,
      },
    );
  }
}
