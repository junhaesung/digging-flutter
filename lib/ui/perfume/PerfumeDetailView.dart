import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/PerfumeDetail.dart';
import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:flutter/material.dart';

class PerfumeDetailView extends StatefulWidget {
  final int perfumeId;

  PerfumeDetailView({required this.perfumeId});

  @override
  State<StatefulWidget> createState() => _PerfumeDetailView(perfumeId);
}

class _PerfumeDetailView extends State<PerfumeDetailView> {
  final int perfumeId;
  final DiggingApi api = DiggingApi();

  _PerfumeDetailView(this.perfumeId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fetchPerfume(perfumeId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return _getLoadingWidget();
        }
        PerfumeDetail perfumeDetail = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              perfumeDetail.name,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff1b1b1b),
              ),
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
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
            child: ListView(
              children: [
                // 향수 이미지
                _getPerfumeImageWidget(perfumeDetail),
                // 향수 이름, 브랜드 이름
                _getPerfumeNameWidget(perfumeDetail),
                Container(height: 12),
                // 탭
                _getTabWidget(),
                Container(
                  height: 8,
                  color: Color(0xfff8f8f8),
                ),
                // Accords
                _getAccordWidget(perfumeDetail),
                // note
                _getNoteWidget(perfumeDetail),
                // 유사한 향수
                _getSimilarPerfumesWidget(perfumeDetail),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getLoadingWidget() => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
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
        body: LinearProgressIndicator(),
      );

  /// 향수 이미지
  Widget _getPerfumeImageWidget(PerfumeDetail perfumeDetail) {
    return Container(
      height: 306,
      child: Image.network(perfumeDetail.imageUrl),
    );
  }

  /// 향수 이름, 디깅
  Widget _getPerfumeNameWidget(PerfumeDetail perfumeDetail) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    perfumeDetail.brandName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffc7c7c7),
                    ),
                  ),
                  Text(
                    perfumeDetail.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b1b1b),
                    ),
                  ),
                  Container(height: 12),
                  // TODO: N 명이 이 향수에 관심있어요.
                  Text(
                    '3명이 이 향수에 관심있어요.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1b1b1b),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xfff0f0f0),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Container(
                  height: 20,
                  child: Image.asset(
                    'images/icon/icon_digging.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 탭바
  Widget _getTabWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff83daff),
                  width: 4.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Text(
                '상품 정보',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1b1b1b),
                ),
              ),
            ),
          ),
          Container(width: 42),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Text(
                '리뷰',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff1b1b1b),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 메인 어코드 정보
  Widget _getAccordWidget(PerfumeDetail perfumeDetail) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '구성 성분',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1b1b1b),
              ),
            ),
            Container(
              height: 34,
            ),
            Column(
              children:
                  perfumeDetail.accords.map((e) => Text(e.toString())).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// 노트 정보
  Widget _getNoteWidget(PerfumeDetail perfumeDetail) {
    return Container(
      height: 375,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '향수 노트',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1b1b1b),
              ),
            ),
            Container(height: 32),
            Row(
              children: [
                Text('top'),
                Text('middle'),
                Text('base'),
              ],
            ),
            Container(height: 32),
            // TODO: '더 보기' 버튼 위치
            Container(
              height: 200,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 100 / 45,
                crossAxisCount: 3,
                crossAxisSpacing: 18.0,
                mainAxisSpacing: 18.0,
                children: (perfumeDetail.notes.topNames
                            .take(5)
                            .map((e) => Text(e))
                            .toList() +
                        [Text('더 보기')])
                    .map((e) => Container(
                          color: Colors.grey,
                          child: e,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 이 향수와 비슷한 제품
  Widget _getSimilarPerfumesWidget(PerfumeDetail perfumeDetail) {
    List<PerfumeSimple> perfumeSimples = perfumeDetail.perfumeSimples;
    return Container(
      height: 375,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이 향수와 비슷한 제품',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1b1b1b),
              ),
            ),
            Container(height: 32),
            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 105 / 167,
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                children: perfumeSimples.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PerfumeDetailView(perfumeId: e.id),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            child: Image.network(
                              e.thumbnailImageUrl,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(height: 8),
                          Text(
                            e.brandName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffababab),
                            ),
                          ),
                          Text(
                            e.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
