class Brand {
  int id;
  String name;
  String logoImageUrl;

  Brand(this.id, this.name, this.logoImageUrl);

  static List<Brand> sampleBrands = [
    Brand(27415, 'Burberry', 'https://fimgs.net/mdimg/dizajneri/o.104.jpg'),
    Brand(27440, 'Bvlgari', 'https://fimgs.net/mdimg/dizajneri/o.14.jpg'),
    Brand(27461, 'Byredo', 'https://fimgs.net/mdimg/dizajneri/o.390.jpg'),
    Brand(27614, 'Chanel', 'https://fimgs.net/mdimg/dizajneri/o.30.jpg'),
    Brand(27700, 'Clean', 'https://fimgs.net/mdimg/dizajneri/o.336.jpg'),
    Brand(27903, 'Dior', 'https://fimgs.net/mdimg/dizajneri/o.160.jpg'),
    Brand(27904, 'Diptyque', 'https://fimgs.net/mdimg/dizajneri/o.421.jpg'),
    Brand(28755, 'Jo Malone London',
        'https://fimgs.net/mdimg/dizajneri/o.273.jpg'),
    Brand(
        28772, 'John Varvatos', 'https://fimgs.net/mdimg/dizajneri/o.242.jpg'),
    Brand(29001, 'Lanvin', 'https://fimgs.net/mdimg/dizajneri/o.81.jpg'),
    Brand(31095, 'Yves Saint Laurent',
        'https://fimgs.net/mdimg/dizajneri/o.99.jpg'),
  ];

  static List<Brand> getBrands() {
    return sampleBrands.toList();
  }
}
