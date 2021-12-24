import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_group_event.dart';
part 'note_group_state.dart';

class NoteGroupBloc extends Bloc<NoteGroupEvent, NoteGroupState> {
  NoteGroupBloc() : super(NoteGroupState()) {
    on<NoteGroupChanged>(_onNoteGroupChanged);
    on<NoteGroupSubmitted>(_onNoteGroupSubmitted);
  }

  _onNoteGroupChanged(
    NoteGroupChanged event,
    Emitter<NoteGroupState> emit,
  ) {
    if (event.noteGroupIds.length <= 3) {
      emit(state.copyWith(noteGroupIds: event.noteGroupIds));
    } else {
      // 4번째 노트 선택했을때 잠깐 멈추면서 진동 울리고싶은데.. 어떻게하징
    }
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
