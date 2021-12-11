import 'package:digging/domain/brand.dart';
import 'package:digging/domain/notegroup.dart';
import 'package:digging/domain/perfume.dart';
import 'package:flutter/material.dart';

/// 1. brand 선택해서 오는 경우
/// 2. 노트그룹 선택해서 오는 경우
/// 3. 추천 선택해서 오는 경우
class MainPerfumeListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPerfumeListView();
}

class _MainPerfumeListView extends State<MainPerfumeListView> {
  late String title;
  late List<Perfume> perfumes;

  @override
  Widget build(BuildContext context) {
    Map<String, Object>? arguments =
        (ModalRoute.of(context)!.settings).arguments as Map<String, Object>?;
    Brand? brand = arguments != null && arguments.containsKey('brand')
        ? arguments['brand'] as Brand
        : null;
    NoteGroup? noteGroup =
        arguments != null && arguments.containsKey('noteGroup')
            ? arguments['noteGroup'] as NoteGroup
            : null;
    String? title = arguments != null && arguments.containsKey('title')
        ? arguments['title'] as String
        : null;

    this.title = brand?.name ?? noteGroup?.name ?? title ?? "";
    this.perfumes = arguments != null && arguments.containsKey('noteGroup')
        ? arguments['perfumes'] as List<Perfume>
        : Perfume.getPerfumes(10);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.title,
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
              children:
                  perfumes.map((e) => toPerfumeListItem(context, e)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget toPerfumeListItem(BuildContext context, Perfume perfume) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          _goToPerfumeDetail(context, perfume);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                children: [
                  Image.network(
                    perfume.imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          perfume.brandName,
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
}
