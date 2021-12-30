class NicknameValidation {
  NicknameValidation({
    required this.isValid,
    required this.message,
  });

  final bool isValid;
  final String message;

  @override
  String toString() {
    return 'NicknameValidation{isValid: $isValid, message: $message}';
  }
}
