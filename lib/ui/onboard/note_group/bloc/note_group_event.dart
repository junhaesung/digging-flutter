part of 'note_group_bloc.dart';

abstract class NoteGroupEvent extends Equatable {
  const NoteGroupEvent();

  @override
  List<Object> get props => [];
}

class NoteGroupChanged extends NoteGroupEvent {
  const NoteGroupChanged({required this.noteGroupIds});

  final NoteGroupIds noteGroupIds;

  @override
  List<Object> get props => [noteGroupIds];
}

class NoteGroupSubmitted extends NoteGroupEvent {
  const NoteGroupSubmitted();
}
