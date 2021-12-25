import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';

class InitializeRequest {
  Gender gender;
  AgeGroup ageGroup;
  NoteGroupIds noteGroupIds;

  InitializeRequest({
    required this.gender,
    required this.ageGroup,
    required this.noteGroupIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'gender': gender.name(),
      'ageGroup': ageGroup.name(),
      'noteGroupIds': noteGroupIds.toSet().toList(),
    };
  }
}
