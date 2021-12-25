import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/adapter/storage/secure_storage_api.dart';
import 'package:digging/domain/brand.dart';
import 'package:digging/domain/notegroup.dart';
import 'package:digging/domain/perfume.dart';
import 'package:digging/session/bloc/session_bloc.dart';
import 'package:digging/ui/main/MainPerfumeListView.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/perfume/PerfumeDetailView.dart';
import 'package:digging/ui/tab_page/bottom_tab_bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  int _selectedNoteGroupId = 0;
  final DiggingApi _api = const DiggingApi();

  @override
  Widget build(BuildContext context) {
    List<NoteGroup> noteGroups =
        NoteGroup.getCategorizedNoteGroups().take(3).toList();
    if (_selectedNoteGroupId == 0) {
      _selectedNoteGroupId = noteGroups.first.id;
    }
    List<Perfume> perfumes = Perfume.getPerfumes(10).toList();

    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) => Scaffold(
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
          // FIXME: (테스트) splash 화면 이동하는 버튼
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _goToSplashView(context);
              },
            ),
          ],
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
              getFavoriteNotePerfume(context, noteGroups, perfumes),
            ],
          ),
        ),
        bottomNavigationBar: BottomTabBar(),
      ),
    );
  }

  /// For you
  Widget getForYouWidget(BuildContext context, List<Perfume> perfumes) {
    Perfume perfume = perfumes.first;
    return Container(
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
                        _goToPerfumeDetailView(context, perfumes.first);
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
                                perfume.imageUrl,
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
                                    perfume.brandName,
                                    style: TextStyle(
                                      color: Color(0xffc7c7c7),
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  perfume.name,
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
  }

  /// 인기브랜드
  Widget getPopularBrandWidget(BuildContext context) {
    List<Brand> brands = Brand.getBrands();
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
                  children: getBrandWidgets(context, brands),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getBrandWidgets(BuildContext context, List<Brand> brands) =>
      brands
          .map((e) => toBrandWidget(context, e, Perfume.getPerfumes(10)))
          .toList();

  Widget toBrandWidget(
    BuildContext context,
    Brand brand,
    List<Perfume> perfumes,
  ) =>
      GestureDetector(
        onTap: () {
          // _goToPerfumeListView(context, brand, perfumes);
          _goToFuturePerfumeListView(context, brand);
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
          ),
        ),
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
                  getRecommendedItem(
                    context,
                    '이달의 향수',
                    Perfume.getPerfumes(10).toList(),
                  ),
                  getRecommendedItem(
                    context,
                    '모든 분들에게 인기가 많아요',
                    Perfume.getPerfumes(10).toList(),
                  ),
                  getRecommendedItem(
                    context,
                    '선물하기 좋은 향수',
                    Perfume.getPerfumes(10).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget getRecommendedItem(
    BuildContext context,
    String title,
    List<Perfume> perfumes,
  ) =>
      Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
        ),
        child: GestureDetector(
          onTap: () {
            _goToPerfumeListViewWithTitleAndPerfumes(
              context,
              title,
              perfumes,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 30,
                right: 12,
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          childAspectRatio: 90 / 150,
                          crossAxisSpacing: 12,
                          children: perfumes
                              .take(3)
                              .map((e) => toPerfumeWidget(e))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
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

  /// 내가 좋아할 노트
  Widget getFavoriteNotePerfume(
    BuildContext context,
    List<NoteGroup> noteGroups,
    List<Perfume> perfumes, // TODO: noteGroups.perfumes
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 30,
        left: 12,
      ),
      child: Container(
        height: 321,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '내가 좋아할 노트',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1b1b1b),
                ),
              ),
              Container(height: 16),
              Container(
                height: 26,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: noteGroups.length,
                  separatorBuilder: (context, index) => Container(width: 10),
                  itemBuilder: (context, index) {
                    NoteGroup noteGroup = noteGroups[index];
                    var selected = noteGroup.id == _selectedNoteGroupId;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedNoteGroupId = noteGroup.id),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              selected ? Color(0xffffeef4) : Color(0xfff3f3f3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          child: Center(
                            child: Text(
                              noteGroup.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selected
                                    ? Color(0xffff5894)
                                    : Color(0xff888888),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: Container(
                  height: 161,
                  child: Row(
                    children: [0, 1]
                        .map((e) => _toNoteGroupPerfumeWidget(
                              context,
                              noteGroups[e],
                              perfumes.getRange(e * 3, (e + 1) * 3).toList(),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toNoteGroupPerfumeWidget(
    BuildContext context,
    NoteGroup noteGroup,
    List<Perfume> perfumes,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          _goToPerfumeDetailView(context, perfumes.first);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 90,
                        child: Image.network(
                          perfumes[0].imageUrl,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(width: 10),
                      Column(
                        children: [
                          Container(
                            width: 35,
                            height: 50,
                            child: Image.network(
                              perfumes[1].imageUrl,
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 50,
                            child: Image.network(
                              perfumes[2].imageUrl,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 12),
              Text(
                noteGroup.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff1b1b1b),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 인기브랜드 -> 향수 목록 화면
  void _goToFuturePerfumeListView(
    BuildContext context,
    Brand brand,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainPerfumeListView.brand(
          title: brand.name,
          brandId: brand.id,
        ),
      ),
    );
  }

  /// 디깅의 추천 향수 -> 향수 목록 화면
  void _goToPerfumeListViewWithTitleAndPerfumes(
    BuildContext context,
    String title,
    List<Perfume> perfumes,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainPerfumeListView.recommendedPerfume(
          title: title,
          perfumes: perfumes,
        ),
      ),
    );
  }

  void _goToPerfumeDetailView(
    BuildContext context,
    Perfume perfume,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PerfumeDetailView(perfumeId: perfume.id),
      ),
    );
  }

  void _goToSearchView(BuildContext context) {
    // Navigator.of(context).pushReplacement(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) => SearchView(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return child;
    //     },
    //   ),
    // );
    // Navigator.of(context).pushReplacement(SearchView.route());
  }

  void _goToSplashView(BuildContext context) async {
    await _api.withdraw();
    TokenStorage()
        .delete()
        .then((value) => context.read<SessionBloc>().add(LoadingRequested()));
  }
}
