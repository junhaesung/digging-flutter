part of 'note_group_bloc.dart';

class NoteGroupState extends Equatable {
  const NoteGroupState({
    this.noteGroupIds = const NoteGroupIds(noteGroupIds: {}),
    this.status = NoteGroupFormStatus.valid,
  });

  final NoteGroupIds noteGroupIds;
  final NoteGroupFormStatus status;

  NoteGroupState copyWith({
    NoteGroupIds? noteGroupIds,
    NoteGroupFormStatus? status,
  }) {
    return NoteGroupState(
      noteGroupIds: noteGroupIds ?? this.noteGroupIds,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [noteGroupIds, status];
}

enum NoteGroupFormStatus {
  valid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

extension NoteGroupFormStatusX on NoteGroupFormStatus {
  bool get isSubmissionInProgress =>
      this == NoteGroupFormStatus.submissionInProgress;
}
