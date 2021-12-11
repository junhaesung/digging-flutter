import 'package:digging/domain/brand.dart';
import 'package:digging/domain/perfume.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('digg'),
            Text(
              'ing',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xff83daff),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // For you
            getForYouWidget(context, Perfume.getPerfumes(1)),
            // 인기브랜드
            getPopularBrandWidget(context),
            // 디깅의 추천 향수
            getRecommendedPerfumeWidget(),
            // 내가 좋아할 노트
            getFavoriteNotePerfume(context),
          ],
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(context),
    );
  }

  BottomNavigationBar getBottomNavigationBar(BuildContext context) =>
      BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            // do nothing
          }
          if (index == 1) {
            goToSearchView(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          // TODO: digging view
        ],
      );
}

/// For you
Widget getForYouWidget(BuildContext context, List<Perfume> perfumes) =>
    Container(
      // height: 382,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 34,
          right: 34,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 21,
                  right: 21,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        goToPerfumeDetailView(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xffe2b949),
                                ),
                                Text(
                                  ' For you',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Image.network(
                                perfumes[0].imageUrl,
                                height: 189,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    perfumes[0].brandName,
                                    style: TextStyle(
                                      color: Color(0xffc7c7c7),
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  perfumes[0].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DotsIndicator(dotsCount: 3, position: 0),
            ),
          ],
        ),
      ),
    );

/// 인기브랜드
Widget getPopularBrandWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30,
      left: 20,
    ),
    child: Container(
      height: 186,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '인기브랜드',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Container(
              height: 86,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getBrandWidgets(context),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget> getBrandWidgets(BuildContext context) =>
    Brand.getBrands().map((e) => toBrandWidget(context, e)).toList();

Widget toBrandWidget(BuildContext context, Brand brand) => GestureDetector(
      onTap: () {
        goToPerfumeListView(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                brand.logoImageUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Color(0xffc7c7c7),
              width: 0.5,
            ),
          ),
        ),
      ),
    );

/// 디깅의 추천 향수
Widget getRecommendedPerfumeWidget() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x3383d9ff), Color(0x33c2b7e4)],
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                '디깅의 추천 향수',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                getRecommendedItem('이달의 향수', Perfume.getPerfumes(3).toList()),
                getRecommendedItem(
                    '모든 분들에게 인기가 많아요', Perfume.getPerfumes(3).toList()),
                getRecommendedItem(
                    '선물하기 좋은 향수', Perfume.getPerfumes(3).toList()),
              ],
            ),
          ],
        ),
      ),
    );

Widget getRecommendedItem(
  String title,
  List<Perfume> perfumes,
) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Container(
            height: 226,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xffc7c7c7),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 150 / 90,
                    crossAxisSpacing: 12,
                    children: perfumes.map((e) => toPerfumeWidget(e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget toPerfumeWidget(Perfume perfume) => Container(
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  perfume.imageUrl,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(height: 8),
          Text(
            perfume.brandName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xffababab),
            ),
          ),
          Text(
            perfume.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

Widget getFavoriteNotePerfume(BuildContext context) {
  return Column(
    children: [
      Text('내가 좋아할 노트'),
      Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('FLOWERS'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('NATURAL & SYNTHETIC'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('CITRUS'),
            ),
          ],
        ),
      ),
      Container(
        height: 200,
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                goToPerfumeListView(context);
              },
              child: Column(
                children: [
                  Text('image'),
                  Text('Note Collection'),
                  Text('2줄까지'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                goToPerfumeListView(context);
              },
              child: Column(
                children: [
                  Text('image'),
                  Text('Note Collection'),
                  Text('2줄까지'),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void goToPerfumeListView(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/main/perfumes',
    arguments: {"key", "value"},
  );
}

void goToPerfumeDetailView(BuildContext context) {
  Navigator.pushNamed(context, '/perfume/detail');
}

void goToSearchView(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/search');
}
