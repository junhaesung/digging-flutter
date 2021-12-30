import 'package:equatable/equatable.dart';

import 'note_group_simple.dart';

class MemberDetail extends Equatable {
  final int id;
  final String status;
  final String ageGroup;
  final List<NoteGroupSimple> noteGroups;
  final String? nickname;

  MemberDetail({
    required this.id,
    required this.status,
    required this.ageGroup,
    required this.noteGroups,
    this.nickname,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return MemberDetail(
      id: json['id'] as int,
      status: json['status'] as String,
      ageGroup: json['ageGroup'] as String,
      noteGroups: (json['noteGroups'] as List)
          .map((e) => NoteGroupSimple.fromJson(e))
          .toList(),
      nickname: json['nickname'] as String?,
    );
  }

  @override
  String toString() {
    return 'MemberDetail{id: $id, status: $status, ageGroup: $ageGroup, noteGroups: $noteGroups, nickname: $nickname}';
  }

  @override
  List<Object?> get props => [id, status];
}
