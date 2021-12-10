import 'package:digging/domain/brand.dart';
import 'package:digging/domain/perfume.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('digging'),
        actions: [
          // TODO: 종모양으로 바꾸기
          Icon(Icons.circle),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // for you
            getForYouWidget(Perfume.getPerfumes(1)),
            // 인기브랜드
            getPopularBrandWidget(),
            // 디깅의 추천 향수
            getRecommendedPerfumeWidget(),
            // 내가 좋아할 노트
            Text('내가 좋아할 노트'),
          ],
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getForYouWidget(List<Perfume> perfumes) => SizedBox(
        height: 300,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Column(
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
              DotsIndicator(dotsCount: 3, position: 0),
            ],
          ),
        ),
      );

  Widget toBrandWidget(Brand brand) => SizedBox(
        height: 70,
        width: 70,
        child: Center(
          child: Image.network(
            brand.logoImageUrl,
            fit: BoxFit.fill,
          ),
        ),
      );

  List<Widget> getBrandWidgets() =>
      Brand.getBrands().map((e) => toBrandWidget(e)).toList();

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

  Widget getPopularBrandWidget() {
    return Container(
      height: 186,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: Text('인기브랜드'),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getBrandWidgets(),
            ),
          ),
        ],
      ),
    );
  }

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
}
