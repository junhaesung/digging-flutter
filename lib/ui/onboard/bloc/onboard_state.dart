part of 'onboard_bloc.dart';

class OnboardState extends Equatable {
  OnboardState({
    this.gender = Gender.UNKNOWN,
    this.ageGroup = AgeGroup.UNKNOWN,
    this.noteGroupIds = const NoteGroupIds(noteGroupIds: {}),
    this.status = OnboardStatus.ready,
  });

  final Gender gender;
  final AgeGroup ageGroup;
  final NoteGroupIds noteGroupIds;
  final OnboardStatus status;

  OnboardState copyWith({
    Gender? gender,
    AgeGroup? ageGroup,
    NoteGroupIds? noteGroupIds,
    OnboardStatus? status,
  }) {
    return OnboardState(
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      noteGroupIds: noteGroupIds ?? this.noteGroupIds,
      status: status ?? this.status,
    );
  }

  OnboardState reset({
    OnboardStatus? status,
  }) {
    return OnboardState(
      gender: Gender.UNKNOWN,
      ageGroup: AgeGroup.UNKNOWN,
      noteGroupIds: const NoteGroupIds(noteGroupIds: {}),
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [gender, ageGroup, noteGroupIds, status];
}
