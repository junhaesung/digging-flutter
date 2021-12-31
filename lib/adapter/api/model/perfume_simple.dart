class PerfumeSimple {
  int id;
  String name;
  String brandName;
  String imageUrl;
  String thumbnailImageUrl;

  PerfumeSimple(
    this.id,
    this.name,
    this.brandName,
    this.imageUrl,
    this.thumbnailImageUrl,
  );

  factory PerfumeSimple.fromJson(Map<String, dynamic> json) {
    return PerfumeSimple(
      json['id'] as int,
      json['name'] as String,
      json['brandName'] as String,
      json['imageUrl'] as String,
      json['thumbnailImageUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'PerfumeSimple{id: $id, name: $name, brandName: $brandName, imageUrl: $imageUrl, thumbnailImageUrl: $thumbnailImageUrl}';
  }
}
