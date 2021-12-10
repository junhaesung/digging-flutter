import 'package:digging/domain/perfume.dart';
import 'package:flutter/material.dart';

class PerfumeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '노트 이름',
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
                            'Bergamot',
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
                    children: Perfume.getPerfumes(10)
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
        _goToPerfumeDetailView(context);
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

  void _goToPerfumeDetailView(BuildContext context) {
    Navigator.pushNamed(context, '/perfume/detail');
  }
}
