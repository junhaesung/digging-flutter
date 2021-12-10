class NoteGroup {
  int id;
  String name;
  String customName;
  String assetImageName;

  NoteGroup(this.id, this.name, this.customName, this.assetImageName);

  static List<NoteGroup> getNoteGroups() {
    return [
      NoteGroup(21180, 'CITRUS SMELLS', 'citrus_yellow', 'images/logo.png'),
      NoteGroup(21181, 'FRUITS & VEGETABLES', 'fruits&vegetables _purple', 'images/logo.png'),
      NoteGroup(21182, 'FLOWERS', 'flowers_pink', 'images/logo.png'),
      NoteGroup(21183, 'WHITE FLOWERS', 'whiteFlowers_skyblue', 'images/logo.png'),
      NoteGroup(21184, 'GREENS', 'greens_green', 'images/logo.png'),
      NoteGroup(21185, 'SPICES', 'spices_brown', 'images/logo.png'),
      NoteGroup(21186, 'SWEETS & GOURMAND', 'sweets&gourmand_pink', 'images/logo.png'),
      NoteGroup(21187, 'WOODS', 'woods_brown', 'images/logo.png'),
      NoteGroup(21188, 'RESINS & BALSMAS', 'resins&balsams_brown', 'images/logo.png'),
      NoteGroup(21189, 'ANIMALIC', 'animalic_orange', 'images/logo.png'),
      NoteGroup(21190, 'BEVERAGES', 'beverages_red', 'images/logo.png'),
      NoteGroup(21191, 'NATURAL & SYNTHETIC', 'natural&systhetic_blue', 'images/logo.png'),
      NoteGroup(21192, 'UNCATEGORIZED', 'uncategorized_black', 'images/logo.png'),
    ];
  }
}
