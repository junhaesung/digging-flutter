part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class LoadingRequested extends SessionEvent {}

class OnboardingRequested extends SessionEvent {}

class MainRequested extends SessionEvent {
  const MainRequested({required this.memberDetail});

  final MemberDetail memberDetail;

  @override
  List<Object> get props => [memberDetail];
}

class WithdrawRequested extends SessionEvent {
  const WithdrawRequested();
}
