enum AgeGroup {
  TEENAGER,
  TWENTIES,
  THIRTIES,
  FORTIES,
  FIFTIES,
  UNKNOWN,
}

extension AgeGroupX on AgeGroup {
  String name() {
    switch(this) {
      case AgeGroup.TEENAGER:
        return 'TEENAGER';
      case AgeGroup.TWENTIES:
        return 'TWENTIES';
      case AgeGroup.THIRTIES:
        return 'THIRTIES';
      case AgeGroup.FORTIES:
        return 'FORTIES';
      case AgeGroup.FIFTIES:
        return 'FIFTIES';
      case AgeGroup.UNKNOWN:
        return 'UNKNOWN';
    }
  }

  int getAge() {
    switch(this) {
      case AgeGroup.TEENAGER:
        return 10;
      case AgeGroup.TWENTIES:
        return 20;
      case AgeGroup.THIRTIES:
        return 30;
      case AgeGroup.FORTIES:
        return 40;
      case AgeGroup.FIFTIES:
        return 50;
      case AgeGroup.UNKNOWN:
        return 0;
    }
  }
}