import 'member_detail.dart';

class LoginResponse {
  final MemberDetail memberDetail;
  final String accessToken;

  LoginResponse({
    required this.memberDetail,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      memberDetail: MemberDetail.fromJson(json['member']),
      accessToken: json['accessToken'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginResponse{memberDetail: $memberDetail, accessToken: $accessToken}';
  }
}
