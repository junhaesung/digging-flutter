class PerfumeSimple {
  int id;
  String name;
  String brandName;
  String thumbnailImageUrl;

  PerfumeSimple(this.id, this.name, this.brandName, this.thumbnailImageUrl);

  factory PerfumeSimple.fromJson(Map<String, dynamic> json) {
    return PerfumeSimple(
      json['id'] as int,
      json['name'] as String,
      json['brandName'] as String,
      json['thumbnailImageUrl'] as String,
    );
  }

  /// api 변경 전까지 임시로 사용하는 메서드
  factory PerfumeSimple.fromJson2(Map<String, dynamic> json) {
    return PerfumeSimple(
      json['id'] as int,
      json['name'] as String,
      json['brand'] as String,
      json['image'] as String,
    );
  }
}
