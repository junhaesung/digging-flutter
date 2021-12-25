part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  const OnboardEvent();

  @override
  List<Object?> get props => [];
}

class OnboardStarted extends OnboardEvent {
  const OnboardStarted();
}

class OnboardStatusChanged extends OnboardEvent {
  const OnboardStatusChanged({required this.status});

  final OnboardStatus status;

  @override
  List<Object?> get props => [status];
}

class OnboardSubmitted extends OnboardEvent {
  const OnboardSubmitted({
    required this.gender,
    required this.ageGroup,
    required this.noteGroupIds,
  });

  final Gender gender;
  final AgeGroup ageGroup;
  final NoteGroupIds noteGroupIds;

  @override
  List<Object?> get props => [gender, ageGroup, noteGroupIds];
}
