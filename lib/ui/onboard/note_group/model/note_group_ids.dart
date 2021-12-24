import 'package:equatable/equatable.dart';

class NoteGroupIds extends Equatable {
  const NoteGroupIds({required this.noteGroupIds});

  final Set<int> noteGroupIds;

  int get length => noteGroupIds.length;

  bool contains(Object? value) => noteGroupIds.contains(value);

  bool add(int value) => noteGroupIds.add(value);

  bool remove(Object? value) => noteGroupIds.remove(value);

  Set<int> union(Set<int> other) => noteGroupIds.union(other);

  Set<int> difference(Set<Object?> other) => noteGroupIds.difference(other);

  @override
  List<Object?> get props => [noteGroupIds];
}
