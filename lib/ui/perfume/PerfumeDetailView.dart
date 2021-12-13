import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/api/model/PerfumeDetail.dart';
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
                Container(
                  height: 375,
                  child: Image.network(perfumeDetail.imageUrl),
                ),
                // 향수 이름, 브랜드 이름
                Container(
                  height: 120,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(perfumeDetail.brandName),
                          Text(perfumeDetail.name),
                          Text('3명이 이 향수에 관심있어요.')
                        ],
                      ),
                      Text('디깅 아이콘'),
                    ],
                  ),
                ),
                // 탭
                Container(
                  height: 48,
                  child: Row(
                    children: [
                      Text('상품 정보'),
                      Text('리뷰'),
                    ],
                  ),
                ),
                // accord
                Container(
                  height: 471,
                  child: Column(
                    children: [
                      Text('구성 성분'),
                      Text('Vanila'),
                      Text('Powdery'),
                      Text('Violet'),
                      Text('Earthy'),
                      Text('Sweet'),
                      Text('Aromatic'),
                      Text('Green'),
                      Text('Floral'),
                      Text('Woody'),
                    ],
                  ),
                ),
                // note
                Container(
                  height: 375,
                  child: Column(
                    children: [
                      Text('향수 노트'),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Top')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Middle')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Bottom')),
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        child: GridView.count(
                          childAspectRatio: 100 / 45,
                          crossAxisCount: 3,
                          children: [
                            Text('Note 1'),
                            Text('Note 2'),
                            Text('Note 3'),
                            Text('Note 4'),
                            Text('Note 5'),
                            Text('더 보기'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 유사한 향수
                Container(
                  height: 375,
                  child: Column(
                    children: [
                      Text('이 향수와 비슷한 제품'),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('이미지 1'),
                              Text('브랜드 이름 1'),
                              Text('향수 이름 1'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('이미지 2'),
                              Text('브랜드 이름 2'),
                              Text('향수 이름 2'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('이미지 3'),
                              Text('브랜드 이름 3'),
                              Text('향수 이름 3'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
}
