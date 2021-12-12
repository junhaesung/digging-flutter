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
}
