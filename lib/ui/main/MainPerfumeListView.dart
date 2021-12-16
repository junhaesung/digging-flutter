import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/BrandDetail.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/domain/perfume.dart';
import 'package:digging/ui/perfume/PerfumeDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPerfumeListView extends StatefulWidget {
  final String title;
  final int? brandId;
  final List<Perfume>? perfumes;

  MainPerfumeListView.brand({
    required this.title,
    required this.brandId,
    this.perfumes,
  });

  MainPerfumeListView.recommendedPerfume({
    required this.title,
    this.brandId,
    required this.perfumes,
  });

  @override
  State<StatefulWidget> createState() => _MainPerfumeListView(
        title,
        brandId,
        perfumes,
      );
}

class _MainPerfumeListView extends State<MainPerfumeListView> {
  final DiggingApi api = DiggingApi();
  final String title;
  int? brandId;
  List<Perfume>? perfumes;

  _MainPerfumeListView(
    this.title,
    this.brandId,
    this.perfumes,
  ) {
    assert(title.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    if (brandId != null) {
      return getBrandWidget(context);
    }
    return getRecommendedPerfumeWidget(context, perfumes!);
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

  Widget getBrandWidget(BuildContext context) {
    return FutureBuilder(
      future: api.fetchBrand(brandId!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return getLoadingWidget();
        }

        BrandDetail brandDetail = snapshot.data;
        List<Perfume> perfumes =
            brandDetail.perfumes.map((e) => _toPerfume(e)).toList();

        return Scaffold(
          appBar: getAppBarWidget(context, title),
          body: getBodyWidget(context, perfumes),
        );
      },
    );
  }

  Widget getRecommendedPerfumeWidget(
    BuildContext context,
    List<Perfume> perfumes,
  ) {
    return Scaffold(
      appBar: getAppBarWidget(context, title),
      body: getBodyWidget(context, perfumes),
    );
  }

  void _goToPerfumeDetail(BuildContext context, Perfume perfume) {
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

  Widget getLoadingWidget() => Scaffold(
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

  PreferredSizeWidget getAppBarWidget(BuildContext context, String title) {
    return AppBar(
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
    );
  }

  Widget getBodyWidget(
    BuildContext context,
    List<Perfume> perfumes,
  ) =>
      SafeArea(
        child: Container(
          color: Color(0xfff3fbff),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: ListView(
              children:
                  perfumes.map((e) => toPerfumeListItem(context, e)).toList(),
            ),
          ),
        ),
      );
}
