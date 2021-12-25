part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  @override
  List<Object> get props => [];
}

/// 초기상태
class Unknown extends SessionState {}

/// 비회원
class Unauthenticated extends SessionState {}

/// 준회원
class Associate extends SessionState {}

/// 정회원
class Authenticated extends SessionState {
  final MemberDetail memberDetail;

  Authenticated({required this.memberDetail});

  @override
  List<Object> get props => [memberDetail];
}
