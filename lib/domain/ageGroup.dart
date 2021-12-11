class AgeGroup {
  int age;
  String name;

  AgeGroup(this.age, this.name);
}

class AgeGroups {
  static List<AgeGroup> _ageGroups = [
    AgeGroup(10, "TEENAGER"),
    AgeGroup(20, "TWENTIES"),
    AgeGroup(30, "THIRTIES"),
    AgeGroup(40, "FOURTIES"),
    AgeGroup(50, "FIFTIES"),
  ];

  static List<AgeGroup> getAgeGroups() {
    return _ageGroups.toList();
  }
}
