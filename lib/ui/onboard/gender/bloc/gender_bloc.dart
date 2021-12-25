import 'dart:async';

import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  GenderBloc({
    required OnboardBloc onboardBloc,
  })  : _onboardBloc = onboardBloc,
        super(GenderState()) {
    on<GenderChanged>(_onGenderChanged);
    on<GenderSubmitted>(_onGenderSubmitted);
    _onboardStateSubscription = _onboardBloc.stream
        .where((state) => state.status == OnboardStatus.ready)
        .listen((state) => add(GenderChanged(gender: state.gender)));
  }

  final OnboardBloc _onboardBloc;
  late StreamSubscription<OnboardState> _onboardStateSubscription;

  /// 현재 누른 버튼을 선택상태로 변경
  /// 이미 선택되어있는 버튼을 누르면 선택해제
  _onGenderChanged(
    GenderChanged event,
    Emitter<GenderState> emit,
  ) {
    final before = state.gender;
    final after = event.gender;
    if (before != after) {
      emit(state.copyWith(
        gender: after,
      ));
    } else {
      emit(state.copyWith(
        gender: Gender.UNKNOWN,
      ));
    }
  }

  _onGenderSubmitted(
    GenderSubmitted event,
    Emitter<GenderState> emit,
  ) {
    emit(state.copyWith(
      status: GenderFormStatus.submissionInProgress,
    ));
  }

  @override
  Future<void> close() async {
    _onboardStateSubscription.cancel();
    super.close();
  }
}
