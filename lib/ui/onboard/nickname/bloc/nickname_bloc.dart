import 'dart:async';

import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/ui/onboard/nickname/model/model.dart';
import 'package:digging/ui/onboard/nickname/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nickname_event.dart';
part 'nickname_state.dart';

class NicknameBloc extends Bloc<NicknameEvent, NicknameState> {
  NicknameBloc({required NicknameRepository nicknameRepository})
      : _nicknameRepository = nicknameRepository,
        super(NicknameState(
          nickname: '',
          validation: NicknameValidation(isValid: true, message: ''),
          status: NicknameStatus.ready,
        )) {
    on<NicknameChanged>(_onNicknameChanged);
    on<NicknameSubmitted>(_onNicknameSubmitted);
    on<NicknameUpdateSuccess>(_onNicknameUpdateSuccess);
    on<NicknameUpdateFailure>(_onNicknameUpdateFailure);
  }

  final NicknameRepository _nicknameRepository;

  FutureOr<void> _onNicknameChanged(
    NicknameChanged event,
    Emitter<NicknameState> emit,
  ) async {
    emit(state.copyWith(
      nickname: event.nickname,
      validation: validate(nickname: event.nickname),
    ));
  }

  FutureOr<void> _onNicknameSubmitted(
    NicknameSubmitted event,
    Emitter<NicknameState> emit,
  ) async {
    if (!state.validation.isValid) {
      return;
    }

    emit(state.copyWith(
      nickname: event.nickname,
      status: NicknameStatus.inProgress,
    ));
    final errorCode =
        await _nicknameRepository.update(nickname: event.nickname);
    if (errorCode == null) {
      add(NicknameUpdateSuccess());
    } else {
      add(NicknameUpdateFailure(errorCode: errorCode));
    }
  }

  FutureOr<void> _onNicknameUpdateSuccess(
    NicknameUpdateSuccess event,
    Emitter<NicknameState> emit,
  ) async {
    emit(state.copyWith(
      validation: NicknameValidation(
        isValid: true,
        message: '',
      ),
      status: NicknameStatus.completed,
    ));
  }

  FutureOr<void> _onNicknameUpdateFailure(
    NicknameUpdateFailure event,
    Emitter<NicknameState> emit,
  ) async {
    if (event.errorCode == ErrorCode.MEMBER_NICKNAME_ALREADY_EXIST) {
      emit(state.copyWith(
        validation: NicknameValidation(
          isValid: false,
          message: '이미 존재하는 닉네임입니다.',
        ),
        status: NicknameStatus.ready,
      ));
    } else {
      emit(state.copyWith(
        validation: NicknameValidation(
          isValid: false,
          message: '요청 실패. 잠시 후 다시 시도해주세요.',
        ),
        status: NicknameStatus.ready,
      ));
    }
  }

  NicknameValidation validate({required String? nickname}) {
    final isValid =
        nickname != null && nickname.length >= 2 && nickname.length <= 6;
    if (nickname == '') {
      return NicknameValidation(isValid: false, message: '',);
    }
    return NicknameValidation(
      isValid: isValid,
      message: isValid ? '' : '2자~6자까지 입력이 가능해요.',
    );
  }
}
