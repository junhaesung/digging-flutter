import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/BrandDetail.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/domain/perfume.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FuturePerfumeListView extends StatefulWidget {
  final int brandId;

  FuturePerfumeListView(this.brandId);

  @override
  State<StatefulWidget> createState() => _FuturePerfumeListView(brandId);
}

class _FuturePerfumeListView extends State<FuturePerfumeListView> {
  final int _brandId;
  final DiggingApi api = DiggingApi();

  _FuturePerfumeListView(this._brandId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.fetchBrand(_brandId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xfff3fbff),
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff1b1b1b),
                  ),
                ),
                toolbarHeight: 44,
              ),
              // body: Text('snapshot has no data. brandId: $_brandId'),
              body: LinearProgressIndicator(),
            );
          }
          BrandDetail brandDetail = snapshot.data;
          var title = brandDetail.name;
          List<Perfume> perfumes =
              brandDetail.perfumes.map((e) => _toPerfume(e)).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff1b1b1b),
                ),
              ),
              backgroundColor: Color(0xfff3fbff),
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff1b1b1b),
                ),
              ),
              toolbarHeight: 44,
            ),
            body: SafeArea(
              child: Container(
                color: Color(0xfff3fbff),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: ListView(
                    children: perfumes
                        .map((e) => toPerfumeListItem(context, e))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget toPerfumeListItem(BuildContext context, Perfume perfume) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          _goToPerfumeDetail(context, perfume);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              children: [
                Image.network(
                  perfume.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          perfume.brandName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffc7c7c7),
                          ),
                        ),
                        Container(
                          height: 4,
                        ),
                        Text(
                          perfume.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToPerfumeDetail(BuildContext context, Perfume perfume) {
    Navigator.pushNamed(
      context,
      '/perfume/detail',
      arguments: {
        "perfume": perfume,
      },
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
}
