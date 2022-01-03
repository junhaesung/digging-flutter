import 'package:carousel_slider/carousel_slider.dart';
import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/adapter/api/model/main_page_response.dart';
import 'package:digging/adapter/api/model/perfume_simple.dart';
import 'package:digging/adapter/api/model/recommend_note_group.dart';
import 'package:digging/adapter/api/model/recommend_perfumes.dart';
import 'package:digging/session/bloc/session_bloc.dart';
import 'package:digging/ui/circular_loading_view.dart';
import 'package:digging/ui/design/digging_color.dart';
import 'package:digging/ui/main/main_perfume_list_view.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/perfume/perfume_detail_view.dart';
import 'package:digging/ui/tab_page/bottom_tab_bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  final DiggingApi _api = const DiggingApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MainPageResponse>(
      future: _api.fetchMainPage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            body: CircularLoadingView(),
          );
        }
        final mainPageResponse = snapshot.data!;
        final hasOnboarded = mainPageResponse.hasOnboarded;
        return BlocBuilder<OnboardBloc, OnboardState>(
          builder: (context, state) => Scaffold(
            appBar: _appBar(context),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    // For you
                    _ForYou(
                      perfumes: mainPageResponse.recommendPerfumes[0].perfumes,
                    ),
                    // 인기 브랜드
                    _PopularBrand(brands: mainPageResponse.popularBrands),
                    // 디깅의 추천 향수
                    _RecommendPerfumes(
                      recommendPerfumes: mainPageResponse.recommendPerfumes,
                      hasOnboarded: hasOnboarded,
                    ),
                    // 내가 좋아할 노트
                    _FavoriteNotes(
                      recommendNoteGroups: mainPageResponse.recommendNoteGroups,
                      hasOnboarded: hasOnboarded,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomTabBar(),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(context) {
    return AppBar(
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
    );
  }

  void _goToSplashView(BuildContext context) async {
    context.read<SessionBloc>().add(WithdrawRequested());
  }
}

/// For you
class _ForYou extends StatefulWidget {
  _ForYou({required this.perfumes});

  final List<PerfumeSimple> perfumes;

  @override
  State<StatefulWidget> createState() => _ForYouState(perfumes);
}

class _ForYouState extends State<_ForYou> {
  _ForYouState(this.perfumes);

  final List<PerfumeSimple> perfumes;

  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 330,
                  onPageChanged: (index, reason) {
                    setState(() {
                      carouselIndex = index;
                    });
                  },
                ),
                items: perfumes.map((perfume) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        child: _forYouCarouselItem(context, perfume),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: carouselIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: DiggingColor.grey,
                    activeColor: DiggingColor.skyBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forYouCarouselItem(BuildContext context, PerfumeSimple perfume) {
    return Container(
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
                _goToPerfumeDetailView(context, perfume);
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
                              color: DiggingColor.grey100,
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
    );
  }
}

void _goToPerfumeDetailView(
  BuildContext context,
  PerfumeSimple perfume,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PerfumeDetailView(perfumeId: perfume.id),
    ),
  );
}

/// 인기 브랜드
class _PopularBrand extends StatelessWidget {
  _PopularBrand({required this.brands});

  final List<BrandSimple> brands;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 30,
        left: 20,
      ),
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
                children: getBrandWidgets(
                  context: context,
                  brands: brands,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getBrandWidgets({
    required BuildContext context,
    required List<BrandSimple> brands,
  }) =>
      brands.map((e) => toBrandWidget(context: context, brand: e)).toList();

  Widget toBrandWidget({
    required BuildContext context,
    required BrandSimple brand,
  }) =>
      GestureDetector(
        onTap: () {
          _goToPerfumeListView(
            context: context,
            brand: brand,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  brand.thumbnailImageUrl,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: DiggingColor.grey100,
                width: 0.5,
              ),
            ),
          ),
        ),
      );

  /// 인기브랜드 -> 향수 목록 화면
  void _goToPerfumeListView({
    required BuildContext context,
    required BrandSimple brand,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainPerfumeListView.brand(
          title: brand.name,
          brandId: brand.id,
        ),
      ),
    );
  }
}

/// 디깅의 추천 향수
class _RecommendPerfumes extends StatelessWidget {
  _RecommendPerfumes({
    required this.recommendPerfumes,
    required this.hasOnboarded,
  });

  final List<RecommendPerfumes> recommendPerfumes;
  final bool hasOnboarded;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                hasOnboarded ? '당신을 위한 추천 향수' : '디깅의 추천 향수',
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
                  hasOnboarded ? '{성별} 인기 향수' : '이달의 향수',
                  recommendPerfumes[1].perfumes,
                ),
                getRecommendedItem(
                  context,
                  '모든 분들에게 인기가 많아요!',
                  recommendPerfumes[2].perfumes,
                ),
                getRecommendedItem(
                  context,
                  hasOnboarded ? '{상큼한 향}, 이 향수 어때요?' : '선물하기 좋은 향수',
                  recommendPerfumes[3].perfumes,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getRecommendedItem(
    BuildContext context,
    String title,
    List<PerfumeSimple> perfumes,
  ) =>
      Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
        ),
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
                        IconButton(
                          onPressed: () {
                            _goToPerfumeListViewWithTitleAndPerfumes(
                              context,
                              title,
                              perfumes,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: DiggingColor.grey100,
                          ),
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
                            .map((e) => toPerfumeWidget(
                                  context: context,
                                  perfume: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget toPerfumeWidget({
    required BuildContext context,
    required PerfumeSimple perfume,
  }) =>
      GestureDetector(
        onTap: () {
          _goToPerfumeDetailView(context, perfume);
        },
        child: Container(
          child: Column(
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      perfume.thumbnailImageUrl,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );

  /// 디깅의 추천 향수 -> 향수 목록 화면
  void _goToPerfumeListViewWithTitleAndPerfumes(
    BuildContext context,
    String title,
    List<PerfumeSimple> perfumes,
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
}

/// 내가 좋아할 노트
class _FavoriteNotes extends StatefulWidget {
  _FavoriteNotes({
    required this.recommendNoteGroups,
    required this.hasOnboarded,
  });

  final List<RecommendNoteGroup> recommendNoteGroups;
  final bool hasOnboarded;

  @override
  State<StatefulWidget> createState() =>
      _FavoriteNotesState(recommendNoteGroups, hasOnboarded);
}

class _FavoriteNotesState extends State<_FavoriteNotes> {
  _FavoriteNotesState(this.recommendNoteGroups, this.hasOnboarded);

  final List<RecommendNoteGroup> recommendNoteGroups;
  final bool hasOnboarded;
  int _selectedNoteGroupId = 0;

  @override
  void initState() {
    super.initState();
    _selectedNoteGroupId = recommendNoteGroups.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasOnboarded ? '취향을 맞춘 노트' : '내가 좋아할 노트',
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
                itemCount: recommendNoteGroups.length,
                separatorBuilder: (context, index) => Container(width: 10),
                itemBuilder: (context, index) {
                  RecommendNoteGroup noteGroup = recommendNoteGroups[index];
                  final selected = noteGroup.id == _selectedNoteGroupId;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedNoteGroupId = noteGroup.id),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selected ? Color(0xffffeef4) : Color(0xfff3f3f3),
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
                          recommendNoteGroups.firstWhere(
                              (ng) => ng.id == _selectedNoteGroupId),
                          e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toNoteGroupPerfumeWidget(
    BuildContext context,
    RecommendNoteGroup recommendNoteGroup,
    int index,
  ) {
    List<PerfumeSimple> perfumes =
        recommendNoteGroup.recommendNotes[index].perfumes;
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
                          perfumes[0].thumbnailImageUrl,
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
                              perfumes[1].thumbnailImageUrl,
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 50,
                            child: Image.network(
                              perfumes[2].thumbnailImageUrl,
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
                recommendNoteGroup.recommendNotes[index].name,
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
}
