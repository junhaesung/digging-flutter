import 'dart:async';

import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'age_group_event.dart';
part 'age_group_state.dart';

class AgeGroupBloc extends Bloc<AgeGroupEvent, AgeGroupState> {
  AgeGroupBloc({
    required OnboardBloc onboardBloc,
  })  : _onboardBloc = onboardBloc,
        super(AgeGroupState()) {
    on<AgeGroupChanged>(_onAgeGroupChanged);
    on<AgeGroupSubmitted>(_onAgeGroupSubmitted);
    _onboardStateSubscription = _onboardBloc.stream
        .where((state) => state.status == OnboardStatus.ready)
        .listen((state) => add(AgeGroupChanged(ageGroup: state.ageGroup)));
  }

  final OnboardBloc _onboardBloc;
  late StreamSubscription<OnboardState> _onboardStateSubscription;

  /// 현재 누른 버튼을 선택상태로 변경
  /// 이미 선택되어있는 버튼을 누르면 선택해제
  _onAgeGroupChanged(
    AgeGroupChanged event,
    Emitter<AgeGroupState> emit,
  ) {
    final before = state.ageGroup;
    final after = event.ageGroup;
    if (before != after) {
      emit(state.copyWith(
        ageGroup: after,
      ));
    } else {
      emit(state.copyWith(
        ageGroup: AgeGroup.UNKNOWN,
      ));
    }
  }

  _onAgeGroupSubmitted(
    AgeGroupSubmitted event,
    Emitter<AgeGroupState> emit,
  ) {
    emit(state.copyWith(
      status: AgeGroupFormStatus.submissionInProgress,
    ));
  }

  @override
  Future<void> close() async {
    _onboardStateSubscription.cancel();
    super.close();
  }
}
