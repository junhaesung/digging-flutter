class UpdateNicknameRequest {
  final String nickname;

  UpdateNicknameRequest(this.nickname);

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
    };
  }
}
