part of 'age_group_bloc.dart';

/// 나이대 정보 관련 이벤트
abstract class AgeGroupEvent extends Equatable {
  const AgeGroupEvent();

  @override
  List<Object?> get props => [];
}

/// 나이대 정보 변경
class AgeGroupChanged extends AgeGroupEvent {
  const AgeGroupChanged({required this.ageGroup}): super();

  final AgeGroup ageGroup;

  @override
  List<Object?> get props => [ageGroup];
}

/// 나이대 정보 제출
class AgeGroupSubmitted extends AgeGroupEvent {
  const AgeGroupSubmitted(): super();
}