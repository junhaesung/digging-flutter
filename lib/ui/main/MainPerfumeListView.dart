import 'package:digging/domain/perfume.dart';
import 'package:flutter/material.dart';

/// 1. brand 선택해서 오는 경우
/// 2. 향수 선택해서 오는 경우
class MainPerfumeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '브랜드이름',
          style: TextStyle(
            fontSize: 16,
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
              children: Perfume.getPerfumes(10)
                  .map((e) => toPerfumeListItem(e))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget toPerfumeListItem(Perfume perfume) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
    );
  }
}
