part of 'age_group_bloc.dart';

/// 나이대 정보 상태 관리
class AgeGroupState extends Equatable {
  const AgeGroupState({
    this.status = AgeGroupFormStatus.valid,
    this.ageGroup = AgeGroup.UNKNOWN,
  });

  final AgeGroup ageGroup;
  final AgeGroupFormStatus status;

  AgeGroupState copyWith({
    AgeGroup? ageGroup,
    AgeGroupFormStatus? status,
  }) {
    return AgeGroupState(
      ageGroup: ageGroup ?? this.ageGroup,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [ageGroup, status];
}

/// 나이대 정보 상태
enum AgeGroupFormStatus {
  valid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

extension AgeGroupFormStatusX on AgeGroupFormStatus {
  bool get isSubmissionInProgress =>
      this == AgeGroupFormStatus.submissionInProgress;
}
