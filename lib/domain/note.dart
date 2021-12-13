import 'dart:math';

class Note {
  int id;
  String name;

  Note(this.id, this.name);

  static List<Note> sampleNotes = [
    Note(21303, 'Loganberry'),
    Note(21358, 'Soybean'),
    Note(21595, 'Snow lotus'),
    Note(21472, 'Heliotrope'),
    Note(21892, 'Dark Chocolate'),
    Note(21776, 'Seaweed'),
    Note(21876, 'Candied Ginger'),
    Note(21632, 'Carissa'),
    Note(21389, 'Azteca Lily'),
    Note(21427, 'Costus'),
    Note(21546, 'Orchid Cactus'),
    Note(21416, 'China Rose'),
    Note(22156, 'Masala Chai'),
    Note(21242, 'Black Currant'),
    Note(21625, 'Wrightia'),
    Note(22167, 'Rhum agricole'),
    Note(21362, 'Tayberry'),
    Note(21239, 'Bearberry'),
    Note(22115, 'skatole'),
    Note(21730, 'Lapsang Souchong Tea'),
    Note(21696, 'Earl Grey Tea'),
    Note(22132, 'Cappuccino'),
    Note(21848, 'Safraleine'),
    Note(22287, 'Slate'),
    Note(22255, 'Melonal'),
    Note(21425, 'Cornflower, Sultan seeds'),
    Note(21793, 'Tieguanyin tea'),
    Note(22197, 'Camphor'),
    Note(21972, 'Cascarilla'),
    Note(22251, 'Lipstick'),
  ];

  static List<Note> getNotes(int count) {
    var notes = List.of(sampleNotes);
    notes.shuffle(Random());
    return notes.take(count).toList();
  }

  @override
  String toString() {
    return 'Note{id: $id, name: $name}';
  }
}
