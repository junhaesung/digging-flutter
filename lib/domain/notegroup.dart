class NoteGroup {
  int id;
  String name;
  String customName;
  String assetImageName;

  NoteGroup(this.id, this.name, this.customName, this.assetImageName);

  static List<NoteGroup> sampleNoteGroups = [
    NoteGroup(21180, 'CITRUS SMELLS', 'citrus_yellow', 'images/note-groups/citrus.png'),
    NoteGroup(21181, 'FRUITS & VEGETABLES', 'fruits&vegetables _purple', 'images/note-groups/fruits.png'),
    NoteGroup(21182, 'FLOWERS', 'flowers_pink', 'images/note-groups/flowers.png'),
    NoteGroup(21183, 'WHITE FLOWERS', 'whiteFlowers_skyblue', 'images/note-groups/white_flowers.png'),
    NoteGroup(21184, 'GREENS', 'greens_green', 'images/note-groups/greens.png'),
    NoteGroup(21185, 'SPICES', 'spices_brown', 'images/note-groups/spices.png'),
    NoteGroup(21186, 'SWEETS & GOURMAND', 'sweets&gourmand_pink', 'images/note-groups/sweets.png'),
    NoteGroup(21187, 'WOODS', 'woods_brown', 'images/note-groups/woods.png'),
    NoteGroup(21188, 'RESINS & BALSMAS', 'resins&balsams_brown', 'images/note-groups/resins.png'),
    NoteGroup(21189, 'ANIMALIC', 'animalic_orange', 'images/note-groups/animalic.png'),
    NoteGroup(21190, 'BEVERAGES', 'beverages_red', 'images/note-groups/beverages.png'),
    NoteGroup(21191, 'NATURAL & SYNTHETIC', 'natural&systhetic_blue', 'images/note-groups/natural.png'),
    NoteGroup(21192, 'UNCATEGORIZED', 'uncategorized_black', 'images/note-groups/uncategorized.png'),
  ];

  static List<NoteGroup> getNoteGroups() {
    return sampleNoteGroups.toList();
  }

  static List<NoteGroup> getCategorizedNoteGroups() {
    return sampleNoteGroups.take(12).toList();
  }
}
