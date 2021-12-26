import 'package:digging/adapter/api/model/brand_simple.dart';
import 'package:digging/ui/search/view/brand_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultBrandItem extends StatelessWidget {
  const SearchResultBrandItem({required this.brand});

  final BrandSimple brand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          // TODO: rootNavigator 뭔지 알아봐야함.
          Navigator.of(context, rootNavigator: true).push(BrandDetailView.route(brand: brand));
        },
        child: Container(
          color: Color(0xfff8f8f8),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(brand.thumbnailImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                    Text(brand.name),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
