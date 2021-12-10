import 'package:digging/domain/brand.dart';
import 'package:digging/domain/perfume.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
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
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // for you
            getForYouWidget(context, Perfume.getPerfumes(1)),
            // 인기브랜드
            getPopularBrandWidget(),
            // 디깅의 추천 향수
            getRecommendedPerfumeWidget(),
            // 내가 좋아할 노트
            getFavoriteNotePerfume(context),
          ],
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  BottomNavigationBar getBottomNavigationBar() => BottomNavigationBar(
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

  /// for you
  Widget getForYouWidget(BuildContext context, List<Perfume> perfumes) =>
      SizedBox(
        height: 300,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  goToPerfumeDetailView(context);
                },
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.star),
                          Text('for you'),
                        ],
                      ),
                    ),
                    Image.network(
                      perfumes[0].imageUrl,
                      height: 189,
                      fit: BoxFit.fill,
                    ),
                    Text(perfumes[0].brandName),
                    Text(perfumes[0].name),
                  ],
                ),
              ),
              DotsIndicator(dotsCount: 3, position: 0),
            ],
          ),
        ),
      );

  /// 인기브랜드
  Widget getPopularBrandWidget() {
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Container(
                height: 86,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getBrandWidgets(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getBrandWidgets() =>
      Brand.getBrands().map((e) => toBrandWidget(e)).toList();

  Widget toBrandWidget(Brand brand) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image.network(
            brand.logoImageUrl,
            fit: BoxFit.fitWidth,
            height: 70,
            width: 70,
          ),
        ),
      );

  Widget getRecommendedPerfumeWidget() => Column(
        children: [
          Text('디깅의 추천 향수'),
          Column(
            children: [
              getRecommendedItem('이달의 향수', Perfume.getPerfumes(3).toList()),
              getRecommendedItem(
                  '모든 분들에게 인기가 많아요', Perfume.getPerfumes(3).toList()),
              getRecommendedItem('선물하기 좋은 향수', Perfume.getPerfumes(3).toList()),
            ],
          ),
        ],
      );

  Widget toPerfumeWidget(Perfume perfume) => Container(
        width: 90,
        child: Column(
          children: [
            Image.network(
              perfume.imageUrl,
              height: 90,
              fit: BoxFit.fill,
            ),
            Text(
              perfume.brandName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              perfume.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  Widget getRecommendedItem(
    String title,
    List<Perfume> perfumes,
  ) =>
      SizedBox(
        height: 226,
        width: 335,
        child: Column(
          children: [
            Text(title),
            Row(
              children: perfumes.map((e) => toPerfumeWidget(e)).toList(),
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

  goToPerfumeListView(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/main/perfumes',
      arguments: {"key", "value"},
    );
  }

  goToPerfumeDetailView(BuildContext context) {
    Navigator.pushNamed(context, '/perfume/detail');
  }
}
