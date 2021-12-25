import 'dart:async';

import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:digging/ui/onboard/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_group_event.dart';
part 'note_group_state.dart';

class NoteGroupBloc extends Bloc<NoteGroupEvent, NoteGroupState> {
  NoteGroupBloc({
    required OnboardBloc onboardBloc,
  })  : _onboardBloc = onboardBloc,
        super(NoteGroupState()) {
    on<NoteGroupAdded>(_onNoteGroupAdded);
    on<NoteGroupRemoved>(_onNoteGroupRemoved);
    on<NoteGroupReset>(_onNoteGroupReset);
    on<NoteGroupSubmitted>(_onNoteGroupSubmitted);
    _onboardStateSubscription = _onboardBloc.stream
        .where((state) => state.status == OnboardStatus.ready)
        .listen((state) => add(NoteGroupReset()));
  }

  final OnboardBloc _onboardBloc;
  late StreamSubscription<OnboardState> _onboardStateSubscription;

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

  FutureOr<void> _onNoteGroupReset(
      NoteGroupReset event,
      Emitter<NoteGroupState> emit,
  ) {
    emit(state.copyWith(
      noteGroupIds: const NoteGroupIds(noteGroupIds: {}),
      status: NoteGroupFormStatus.valid,
    ));
  }

  _onNoteGroupSubmitted(
    NoteGroupSubmitted event,
    Emitter<NoteGroupState> emit,
  ) {
    emit(state.copyWith(
      status: NoteGroupFormStatus.submissionInProgress,
    ));
  }

  @override
  Future<void> close() async {
    _onboardStateSubscription.cancel();
    super.close();
  }
}
