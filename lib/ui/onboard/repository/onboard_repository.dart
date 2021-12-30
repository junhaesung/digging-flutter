import 'dart:async';

import 'package:digging/adapter/api/digging_api.dart';
import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';

enum OnboardStatus {
  // initialized
  ready,
  // processing
  nickname,
  genderAndAge,
  noteGroup,
  // completed
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

extension OnboardStatusX on OnboardStatus {
  bool hasPage() {
    switch (this) {
      case OnboardStatus.ready:
      case OnboardStatus.nickname:
      case OnboardStatus.genderAndAge:
      case OnboardStatus.noteGroup:
        return true;
      case OnboardStatus.submissionInProgress:
      case OnboardStatus.submissionSuccess:
      case OnboardStatus.submissionFailure:
        return false;
    }
  }
}

class OnboardRepository {
  final DiggingApi _api = DiggingApi();
  final _controller = StreamController<OnboardStatus>();

  Stream<OnboardStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield OnboardStatus.ready;
    yield* _controller.stream;
  }

  Future<void> initialize({
    required Gender gender,
    required AgeGroup ageGroup,
    required NoteGroupIds noteGroupIds,
  }) async {
    _controller.add(OnboardStatus.submissionInProgress);
    final errorCode = await _api.initialize(gender, ageGroup, noteGroupIds);
    if (errorCode == null) {
      print('initialize success');
      _controller.add(OnboardStatus.submissionSuccess);
    } else {
      print('initialize failure');
      _controller.add(OnboardStatus.submissionFailure);
    }
  }

  void dispose() {
    _controller.close();
  }
}
