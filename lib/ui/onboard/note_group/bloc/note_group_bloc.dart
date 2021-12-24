import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_group_event.dart';
part 'note_group_state.dart';

class NoteGroupBloc extends Bloc<NoteGroupEvent, NoteGroupState> {
  NoteGroupBloc() : super(NoteGroupState()) {
    on<NoteGroupAdded>(_onNoteGroupAdded);
    on<NoteGroupRemoved>(_onNoteGroupRemoved);
    on<NoteGroupSubmitted>(_onNoteGroupSubmitted);
  }

  _onNoteGroupAdded(
    NoteGroupAdded event,
    Emitter<NoteGroupState> emit,
  ) {
    if (state.noteGroupIds.contains(event.noteGroupId)) {
      return;
    }
    if (state.noteGroupIds.length >= 3) {
      // 4번째 노트 선택했을때 잠깐 멈추면서 진동 울리고싶은데.. 어떻게하징
      return;
    }
    final union = state.noteGroupIds.union({event.noteGroupId});
    final noteGroupIds = NoteGroupIds(noteGroupIds: union);
    emit(state.copyWith(noteGroupIds: noteGroupIds));
  }

  _onNoteGroupRemoved(
    NoteGroupRemoved event,
    Emitter<NoteGroupState> emit,
  ) {
    if (!state.noteGroupIds.contains(event.noteGroupId)) {
      return;
    }
    final difference = state.noteGroupIds.difference({event.noteGroupId});
    final noteGroupIds = NoteGroupIds(noteGroupIds: difference);
    emit(state.copyWith(noteGroupIds: noteGroupIds));
  }

  _onNoteGroupSubmitted(
    NoteGroupSubmitted event,
    Emitter<NoteGroupState> emit,
  ) {
    emit(state.copyWith(
      status: NoteGroupFormStatus.submissionInProgress,
    ));
  }
}
