part of 'gender_bloc.dart';

/// 성별 정보 상태 관리
class GenderState extends Equatable {
  const GenderState({
    this.status = GenderFormStatus.valid,
    this.gender = Gender.UNKNOWN,
  });

  final Gender gender;
  final GenderFormStatus status;

  GenderState copyWith({
    Gender? gender,
    GenderFormStatus? status,
  }) {
    return GenderState(
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [gender, status];
}

/// 성별 정보 상태
enum GenderFormStatus {
  valid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

extension GenderFormStatusX on GenderFormStatus {
  bool get isSubmissionInProgress =>
      this == GenderFormStatus.submissionInProgress;
}
