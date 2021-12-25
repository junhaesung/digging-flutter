import 'dart:async';

import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/session/session.dart';
import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc({
    required SessionBloc sessionBloc,
    required OnboardRepository onboardRepository,
  })  : _sessionBloc = sessionBloc,
        _onboardRepository = onboardRepository,
        super(OnboardState()) {
    on<OnboardStarted>(_onOnboardStarted);
    on<OnboardStatusChanged>(_onOnboardStatusChanged);
    on<OnboardSubmitted>(_onOnboardSubmitted);
    _onboardStatusSubscription = _onboardRepository.status.listen(
      (status) => add(OnboardStatusChanged(status: status)),
    );
    _sessionStateSubscription = _sessionBloc.stream
        .where((e) => e is Associate)
        .listen((e) => add(OnboardStarted()));
  }

  final OnboardRepository _onboardRepository;
  final SessionBloc _sessionBloc;
  final DiggingApi _api = DiggingApi();
  late StreamSubscription<OnboardStatus> _onboardStatusSubscription;
  late StreamSubscription<SessionState> _sessionStateSubscription;

  Future<void> _onOnboardStarted(
    OnboardStarted event,
    Emitter<OnboardState> emit,
  ) async {
    emit(state.reset(
      status: OnboardStatus.ready,
    ));
  }

  Future<void> _onOnboardStatusChanged(
    OnboardStatusChanged event,
    Emitter<OnboardState> emit,
  ) async {
    switch (event.status) {
      case OnboardStatus.ready:
        emit(state.reset(status: event.status));
        return;
      case OnboardStatus.nickname:
      case OnboardStatus.genderAndAge:
      case OnboardStatus.noteGroup:
        emit(state.copyWith(status: event.status));
        return;
      case OnboardStatus.submissionSuccess:
      case OnboardStatus.submissionFailure:
        final memberDetail = await _api.fetchMyInfo();
        _sessionBloc.add(MainRequested(memberDetail: memberDetail));
        emit(state.copyWith(status: state.status));
        return;
      default:
        emit(state.copyWith(status: state.status));
        return;
    }
  }

  Future<void> _onOnboardSubmitted(
    OnboardSubmitted event,
    Emitter<OnboardState> emit,
  ) async {
    // TODO: need to check state is valid
    try {
      await _onboardRepository.initialize(
        gender: event.gender,
        ageGroup: event.ageGroup,
        noteGroupIds: event.noteGroupIds,
      );
      emit(state.reset(status: OnboardStatus.submissionSuccess));
    } catch (exception) {
      print('Failed to initialize. exception:$exception');
      emit(state.copyWith(status: OnboardStatus.submissionFailure));
    }
  }

  @override
  Future<void> close() async {
    _onboardStatusSubscription.cancel();
    _sessionStateSubscription.cancel();
    _onboardRepository.dispose();
    super.close();
  }
}
