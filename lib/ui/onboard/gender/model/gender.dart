enum Gender {
  FEMALE,
  MALE,
  UNKNOWN,
}

extension GenderX on Gender {

  static Gender valueOf(String value) {
    switch (value) {
      case 'FEMALE':
        return Gender.FEMALE;
      case 'MALE':
        return Gender.MALE;
      default:
        return Gender.UNKNOWN;
    }
  }

  String name() {
    switch (this) {
      case Gender.FEMALE:
        return 'FEMALE';
      case Gender.MALE:
        return 'MALE';
      case Gender.UNKNOWN:
        return 'UNKNOWN';
    }
  }

  String buttonName() {
    switch (this) {
      case Gender.FEMALE:
        return '여성';
      case Gender.MALE:
        return '남성';
      case Gender.UNKNOWN:
        return 'UNKNOWN';
    }
  }
}