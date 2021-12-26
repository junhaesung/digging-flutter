import 'package:digging/adapter/api/model/PerfumeSimple.dart';
import 'package:digging/ui/perfume/PerfumeDetailView.dart';
import 'package:flutter/material.dart';

class SearchResultPerfumeItem extends StatelessWidget {
  const SearchResultPerfumeItem({required this.perfume});

  final PerfumeSimple perfume;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(PerfumeDetailView.route(perfumeId: perfume.id));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: Row(
            children: [
              // image
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  width: 80,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(perfume.thumbnailImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(perfume.brandName),
                    Container(height: 4),
                    Text(perfume.name),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
