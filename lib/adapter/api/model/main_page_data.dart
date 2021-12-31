import 'package:digging/adapter/api/model/main_page_response.dart';

class MainPageData {
  final MainPageResponse mainPageResponse;

  MainPageData({required this.mainPageResponse});

  factory MainPageData.fromJson(Map<String, dynamic> json) {
    return MainPageData(
      mainPageResponse: MainPageResponse.fromJson(json['mainRecommend']),
    );
  }

  @override
  String toString() {
    return 'MainPageData{mainPageResponse: $mainPageResponse}';
  }
}
