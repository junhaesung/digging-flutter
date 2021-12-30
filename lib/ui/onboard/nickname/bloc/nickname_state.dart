part of 'nickname_bloc.dart';

class NicknameState extends Equatable {
  const NicknameState({
    required this.nickname,
    required this.validation,
    required this.status,
  });

  final String nickname;
  final NicknameValidation validation;
  final NicknameStatus status;

  @override
  List<Object?> get props => [nickname, validation, status];

  NicknameState copyWith({
    String? nickname,
    NicknameValidation? validation,
    NicknameStatus? status,
  }) {
    return NicknameState(
      nickname: nickname ?? this.nickname,
      validation: validation ?? this.validation,
      status: status ?? this.status,
    );
  }
}
