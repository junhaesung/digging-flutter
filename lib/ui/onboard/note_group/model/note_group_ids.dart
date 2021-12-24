import 'package:equatable/equatable.dart';

class NoteGroupIds extends Equatable {
  const NoteGroupIds({required this.noteGroupIds});

  final Set<int> noteGroupIds;

  int get length => noteGroupIds.length;

  @override
  List<Object?> get props => [noteGroupIds];
}
