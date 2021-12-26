class BrandSimple {
  BrandSimple({
    required this.id,
    required this.name,
    required this.thumbnailImageUrl,
  });

  final int id;
  final String name;
  final String thumbnailImageUrl;

  factory BrandSimple.fromJson(Map<String, dynamic> json) {
    return BrandSimple(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'BrandSimple{id: $id, name: $name, thumbnailImageUrl: $thumbnailImageUrl}';
  }
}
