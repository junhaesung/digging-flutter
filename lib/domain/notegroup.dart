class NoteGroup {
  int id;
  String name;
  String description;
  String customName;
  String assetImageName;

  NoteGroup(this.id, this.name, this.description, this.customName, this.assetImageName);

  static List<NoteGroup> _sampleNoteGroups = [
    NoteGroup(21180, 'CITRUS SMELLS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'citrus_yellow', 'images/note-groups/citrus.png'),
    NoteGroup(21181, 'FRUITS & VEGETABLES', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'fruits&vegetables _purple', 'images/note-groups/fruits.png'),
    NoteGroup(21182, 'FLOWERS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'flowers_pink', 'images/note-groups/flowers.png'),
    NoteGroup(21183, 'WHITE FLOWERS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'whiteFlowers_skyblue', 'images/note-groups/white_flowers.png'),
    NoteGroup(21184, 'GREENS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'greens_green', 'images/note-groups/greens.png'),
    NoteGroup(21185, 'SPICES', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'spices_brown', 'images/note-groups/spices.png'),
    NoteGroup(21186, 'SWEETS & GOURMAND', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'sweets&gourmand_pink', 'images/note-groups/sweets.png'),
    NoteGroup(21187, 'WOODS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'woods_brown', 'images/note-groups/woods.png'),
    NoteGroup(21188, 'RESINS & BALSMAS', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'resins&balsams_brown', 'images/note-groups/resins.png'),
    NoteGroup(21189, 'ANIMALIC', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'animalic_orange', 'images/note-groups/animalic.png'),
    NoteGroup(21190, 'BEVERAGES', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'beverages_red', 'images/note-groups/beverages.png'),
    NoteGroup(21191, 'NATURAL & SYNTHETIC', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'natural&systhetic_blue', 'images/note-groups/natural.png'),
    NoteGroup(21192, 'UNCATEGORIZED', '시트러스는 달콤하면서도 신선한 감귤류의 향을 포함한다.', 'uncategorized_black', 'images/note-groups/uncategorized.png'),
  ];

  static List<NoteGroup> getNoteGroups() {
    return _sampleNoteGroups.toList();
  }

  static List<NoteGroup> getCategorizedNoteGroups() {
    return _sampleNoteGroups.take(12).toList();
  }
}
