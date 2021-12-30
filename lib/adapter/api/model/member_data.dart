import 'package:digging/adapter/api/model/member_detail.dart';

class MemberData {
  MemberDetail memberDetail;

  MemberData({required this.memberDetail});

  factory MemberData.fromJson(Map<String, dynamic> json) {
    return MemberData(
      memberDetail: MemberDetail.fromJson(json['member']),
    );
  }
}
