import 'dart:math';

class Perfume {
  int id;
  String name;
  String brandName;
  String imageUrl;

  Perfume(this.id, this.name, this.brandName, this.imageUrl);

  static List<Perfume> samplePerfumes = [
    Perfume(102344, 'The Road to Paradise is Rough', 'Route 66',
        'https://fimgs.net/mdimg/perfume/375x500.69123.jpg'),
    Perfume(658578, 'Just Wow Let\'s Party', 'Croatian Perfume House',
        'https://fimgs.net/mdimg/perfume/375x500.48190.jpg'),
    Perfume(664501, 'Concombre & Aloes', 'Dans un Jardin',
        'https://fimgs.net/mdimg/perfume/375x500.42814.jpg'),
    Perfume(851319, 'Swing Exstasy Night', 'Julian Rouas',
        'https://fimgs.net/mdimg/perfume/375x500.7603.jpg'),
    Perfume(1034279, '84 - Youth, But Not Innocence', 'OSM',
        'https://fimgs.net/mdimg/perfume/375x500.56902.jpg'),
    Perfume(636829, 'Arc-en-Ciel № 10', 'CIEL Parfum',
        'https://fimgs.net/mdimg/perfume/375x500.34123.jpg'),
    Perfume(366637, 'Qafiya 4', 'Ajmal',
        'https://fimgs.net/mdimg/perfume/375x500.49545.jpg'),
    Perfume(1049069, 'Cuir Rouge', 'Parfums et Senteurs du Pays Basque',
        'https://fimgs.net/mdimg/perfume/375x500.17250.jpg'),
    Perfume(170965, 'Si Lolita', 'Lolita Lempicka',
        'https://fimgs.net/mdimg/perfume/375x500.6433.jpg'),
    Perfume(236544, 'Eau de Monsieur', 'Goutal',
        'https://fimgs.net/mdimg/perfume/375x500.2753.jpg'),
    Perfume(1011176, 'Capricho Rock', 'O Boticario',
        'https://fimgs.net/mdimg/perfume/375x500.18996.jpg'),
    Perfume(54541, 'Cool Water Parfum', 'Davidoff',
        'https://fimgs.net/mdimg/perfume/375x500.66525.jpg'),
    Perfume(475041, 'Maxsus Silver', 'Alan Bray',
        'https://fimgs.net/mdimg/perfume/375x500.26720.jpg'),
    Perfume(669744, 'Lotus Flower', 'Demeter Fragrance',
        'https://fimgs.net/mdimg/perfume/375x500.26008.jpg'),
    Perfume(562782, 'Luiza Brunet Night', 'Avon',
        'https://fimgs.net/mdimg/perfume/375x500.43143.jpg'),
    Perfume(710134, '#220 Honey Potion', 'EMES',
        'https://fimgs.net/mdimg/perfume/375x500.61545.jpg'),
    Perfume(200081, 'Blueberry', 'Demeter Fragrance',
        'https://fimgs.net/mdimg/perfume/375x500.17882.jpg'),
    Perfume(588590, 'Ladon', 'Black Phoenix Alchemy Lab',
        'https://fimgs.net/mdimg/perfume/375x500.16129.jpg'),
    Perfume(319267, 'No 88', 'Czech & Speake',
        'https://fimgs.net/mdimg/perfume/375x500.6429.jpg'),
    Perfume(711846, 'Elegante', 'Emper',
        'https://fimgs.net/mdimg/perfume/375x500.22148.jpg'),
    Perfume(979881, 'Biografia Caminhos', 'Natura',
        'https://fimgs.net/mdimg/perfume/375x500.67391.jpg'),
    Perfume(822227, 'Club 75 VIP', 'Jacques Bogart',
        'https://fimgs.net/mdimg/perfume/375x500.51936.jpg'),
    Perfume(921921, 'Mina', 'Maar',
        'https://fimgs.net/mdimg/perfume/375x500.60817.jpg'),
    Perfume(400616, 'Softwater', 'Overose',
        'https://fimgs.net/mdimg/perfume/375x500.70036.jpg'),
    Perfume(997853, 'Lumen-esce', 'Nomenclature',
        'https://fimgs.net/mdimg/perfume/375x500.41622.jpg'),
    Perfume(964619, 'Vivre', 'Molyneux',
        'https://fimgs.net/mdimg/perfume/375x500.56270.jpg'),
    Perfume(687186, 'Spirit Lamp', 'DS&Durga',
        'https://fimgs.net/mdimg/perfume/375x500.42251.jpg'),
    Perfume(758714, 'Navvab', 'FUMparFUM',
        'https://fimgs.net/mdimg/perfume/375x500.69606.jpg'),
    Perfume(772616, 'Insence Ultramarine Hawaii', 'Givenchy',
        'https://fimgs.net/mdimg/perfume/375x500.2948.jpg'),
    Perfume(275783, 'Musc Eau de Parfum', 'Molinard',
        'https://fimgs.net/mdimg/perfume/375x500.31837.jpg'),
  ];

  static List<Perfume> getPerfumes(int count) {
    samplePerfumes.shuffle(Random());
    return samplePerfumes.take(count).toList();
  }

  @override
  String toString() {
    return 'Perfume{id: $id, name: $name, brandName: $brandName, imageUrl: $imageUrl}';
  }
}
