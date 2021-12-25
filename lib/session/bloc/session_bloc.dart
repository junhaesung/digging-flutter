import 'package:digging/adapter/api/model/MemberDetail.dart';
import 'package:digging/auth/auth.dart';
import 'package:digging/util/device_id_resolver.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(Unknown()) {
    on<LoadingRequested>(_onLoadingRequested);
    on<OnboardingRequested>(_onOnboardingRequested);
    on<MainRequested>(_onMainRequested);
    this.add(LoadingRequested());
  }

  final AuthRepository _authRepository;

  Future<void> _onLoadingRequested(
    LoadingRequested event,
    Emitter<SessionState> emit,
  ) async {
    print('_onLoadingRequested. \nevent: $event, \nstate: $state');
    // 로그인
    try {
      var uuid = await DeviceIdResolver.resolveDeviceId();
      final memberDetail = await _authRepository.attemptAutoLogin(uuid);
      if (memberDetail.status == 'ACTIVE') {
        emit(Authenticated(memberDetail: memberDetail));
      } else {
        emit(Associate());
      }
    } on Exception {
      emit(Associate());
    }
  }

  Future<void> _onOnboardingRequested(
    OnboardingRequested event,
    Emitter<SessionState> emit,
  ) async {
    print('_onOnboardingRequested. \nevent: $event, \nstate: $state');
    emit(Associate());
  }

  Future<void> _onMainRequested(
    MainRequested event,
    Emitter<SessionState> emit,
  ) async {
    print('_onMainRequested. \nevent: $event, \nstate: $state');
    emit(Authenticated(memberDetail: event.memberDetail));
  }
}
