import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/adapter/api/model/brand_detail.dart';
import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/adapter/api/model/perfume_simple.dart';
import 'package:digging/ui/linear_loading_view.dart';
import 'package:digging/ui/search/view/result/item/search_result_perfume_item.dart';
import 'package:flutter/material.dart';

class BrandDetailView extends StatelessWidget {
  static Route route({required BrandSimple brand}) {
    return MaterialPageRoute(
      builder: (_) => BrandDetailView(
        brand: brand,
      ),
    );
  }

  BrandDetailView({required this.brand});

  final DiggingApi _api = DiggingApi();
  final BrandSimple brand;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _api.fetchBrand(brand.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearLoadingView();
        }
        List<PerfumeSimple> perfumes = (snapshot.data as BrandDetail).perfumes;
        return Scaffold(
          appBar: _appBar(context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: perfumes
                    .map((e) => SearchResultPerfumeItem(perfume: e))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        brand.name,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff1b1b1b),
        ),
      ),
      toolbarHeight: 44,
      elevation: 0.0,
      backgroundColor: Color(0xfff8f8f8),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff1b1b1b),
        ),
      ),
    );
  }
}
