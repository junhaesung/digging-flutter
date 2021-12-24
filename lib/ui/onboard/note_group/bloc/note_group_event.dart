part of 'note_group_bloc.dart';

abstract class NoteGroupEvent extends Equatable {
  const NoteGroupEvent();

  @override
  List<Object> get props => [];
}

class NoteGroupAdded extends NoteGroupEvent {
  const NoteGroupAdded({required this.noteGroupId});

  final int noteGroupId;

  @override
  List<Object> get props => [noteGroupId];
}

class NoteGroupRemoved extends NoteGroupEvent {
  const NoteGroupRemoved({required this.noteGroupId});

  final int noteGroupId;

  @override
  List<Object> get props => [noteGroupId];
}

class NoteGroupSubmitted extends NoteGroupEvent {
  const NoteGroupSubmitted();
}
