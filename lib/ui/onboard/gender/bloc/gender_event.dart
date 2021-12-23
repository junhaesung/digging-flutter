part of 'gender_bloc.dart';

/// 성별 정보 관련 이벤트
abstract class GenderEvent extends Equatable {
  const GenderEvent();

  @override
  List<Object> get props => [];
}

/// 성별 정보 변경
class GenderChanged extends GenderEvent {
  const GenderChanged({required this.gender});

  final Gender gender;

  @override
  List<Object> get props => [gender];
}

/// 성별 정보 제출
class GenderSubmitted extends GenderEvent {
  const GenderSubmitted();
}