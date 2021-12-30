part of 'nickname_bloc.dart';

abstract class NicknameEvent extends Equatable {
  const NicknameEvent();

  @override
  List<Object> get props => [];
}

class NicknameChanged extends NicknameEvent {
  const NicknameChanged({required this.nickname});

  final String nickname;

  @override
  List<Object> get props => [nickname];
}

class NicknameSubmitted extends NicknameEvent {
  const NicknameSubmitted({required this.nickname});

  final String nickname;

  @override
  List<Object> get props => [nickname];
}

class NicknameUpdateSuccess extends NicknameEvent {
  const NicknameUpdateSuccess();
}

class NicknameUpdateFailure extends NicknameEvent {
  const NicknameUpdateFailure({required this.errorCode});

  final ErrorCode errorCode;

  @override
  List<Object> get props => [errorCode];
}
