import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/adapter/api/model/accord.dart';
import 'package:digging/adapter/api/model/perfume_detail.dart';
import 'package:digging/adapter/api/model/perfume_notes.dart';
import 'package:digging/adapter/api/model/perfume_simple.dart';
import 'package:digging/ui/design/digging_color.dart';
import 'package:digging/util/string_color_converter.dart';
import 'package:flutter/material.dart';

class PerfumeDetailView extends StatelessWidget {
  static Route route({required int perfumeId}) {
    return MaterialPageRoute(
      builder: (context) => PerfumeDetailView(perfumeId: perfumeId),
    );
  }

  const PerfumeDetailView({required this.perfumeId});

  final int perfumeId;
  final DiggingApi api = const DiggingApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fetchPerfume(perfumeId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return _getLoadingWidget(context);
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
                _NoteViewer(perfumeDetail: perfumeDetail),
                // 유사한 향수
                _getSimilarPerfumesWidget(context, perfumeDetail),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getLoadingWidget(BuildContext context) => Scaffold(
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
                      color: DiggingColor.grey100,
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
    return Padding(
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
          _accordList(perfumeDetail.accords)
        ],
      ),
    );
  }

  Widget _accordList(List<Accord> accords) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫번쨰껀 글씨 굵게
        // 4번째부터는 회색에 매핑
        Row(
          children: [
            Container(
              height: 60,
              width: 95,
              color: (accords.length >= 1)
                  ? StringColorConverter.toColor(accords[0].backgroundColor)
                  : Color(0xfffffdc7),
            ),
            Container(width: 8),
            Text((accords.length >= 1) ? accords[0].name : ''),
          ],
        ),
        Row(
          children: [
            Container(
              height: 60,
              width: 95,
              color: (accords.length >= 2)
                  ? StringColorConverter.toColor(accords[1].backgroundColor)
                  : Color(0xffecdfd1),
            ),
            Container(width: 8),
            Text((accords.length >= 2) ? accords[1].name : ''),
          ],
        ),
        Row(
          children: [
            Container(
              height: 60,
              width: 95,
              color: (accords.length >= 3)
                  ? StringColorConverter.toColor(accords[2].backgroundColor)
                  : Color(0xffcfbcdc),
            ),
            Container(width: 8),
            Text((accords.length >= 3) ? accords[2].name : ''),
          ],
        ),
        Row(
          children: [
            Container(
              height: 180,
              width: 95,
              color: Colors.grey,
            ),
            Container(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (accords.length >= 3)
                  ? accords.sublist(3).map((e) => Text(e.name)).toList()
                  : [],
            ),
          ],
        ),
      ],
    );
  }

  /// 이 향수와 비슷한 제품
  Widget _getSimilarPerfumesWidget(
    BuildContext context,
    PerfumeDetail perfumeDetail,
  ) {
    List<PerfumeSimple> perfumeSimples = perfumeDetail.perfumeSimples;
    return Container(
      height: 300,
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

/// 향수 노트
class _NoteViewer extends StatefulWidget {
  const _NoteViewer({required this.perfumeDetail});

  final PerfumeDetail perfumeDetail;

  @override
  State<StatefulWidget> createState() => _NoteViewState(
        perfumeDetail: perfumeDetail,
      );
}

class _NoteViewState extends State<_NoteViewer> {
  _NoteViewState({required this.perfumeDetail});

  final PerfumeDetail perfumeDetail;
  int _noteSelector = 0;

  @override
  Widget build(BuildContext context) {
    // top, middle, base 노트가 모두 없으면, '향수 노트' 부분을 보여주지 않는다.
    if (perfumeDetail.notes.isEmpty()) {
      return Container();
    }
    return Container(
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
            Container(
              height: 36,
              child: Row(
                children: [
                  _noteTypeSelector('Top', 0),
                  _noteTypeSelector('Middle', 1),
                  _noteTypeSelector('Base', 2),
                ],
              ),
            ),
            Container(height: 32),
            _noteList(perfumeDetail.notes),
          ],
        ),
      ),
    );
  }

  Widget _noteTypeSelector(String name, int selectorValue) {
    final selected = _noteSelector == selectorValue;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _noteSelector = selectorValue;
          });
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: selected ? null : Border.all(color: DiggingColor.grey100),
            color: selected ? Color(0xff83daff) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 28.0,
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? Colors.white : Color(0xff888888),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _noteList(PerfumeNotes notes) {
    List<String> noteNames;
    if (_noteSelector == 0) {
      noteNames = notes.topNames;
    } else if (_noteSelector == 1) {
      noteNames = notes.middleNames;
    } else {
      noteNames = notes.baseNames;
    }
    if (noteNames.isEmpty) {
      return Container(height: 150);
    }
    final needsMoreButton = noteNames.length > 5;
    return Container(
      height: 150,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 100 / 55,
        crossAxisCount: 3,
        crossAxisSpacing: 18.0,
        mainAxisSpacing: 18.0,
        children: noteNames.take(5).map((e) => _note(e)).toList() +
            (needsMoreButton ? [_moreButton()] : []),
      ),
    );
  }

  Widget _note(String noteName) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xfff8f8f8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            noteName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff1b1b1b),
            ),
          ),
        ),
      ),
    );
  }

  Widget _moreButton() {
    return GestureDetector(
      onTap: () {},
      child: _note('더 보기'),
    );
  }
}
