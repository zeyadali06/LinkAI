import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failures/request_result.dart';
import '../../../domain/useCases/changeEmailCheckPasswordUseCase/change_email_check_password_use_case.dart';
import '../../../domain/useCases/changeEmailSendOTPUseCase/change_email_send_otp_use_case.dart';
import '../../../domain/useCases/changeEmailEnterNewEmailUseCase/change_email_enter_new_email_use_case.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  final ChangeEmailCheckPasswordUseCase _checkPasswordUseCase;
  final ChangeEmailSendOTPUseCase _sendOTPUseCase;
  final ChangeEmailEnterNewEmailUseCase _enterNewEmailUseCase;

  ChangeEmailCubit(
    this._checkPasswordUseCase,
    this._sendOTPUseCase,
    this._enterNewEmailUseCase,
  ) : super(ChangeEmailInitial());

  static ChangeEmailCubit get(context) => BlocProvider.of(context);

  Future<void> checkPassword(String password) async {
    emit(ChangeEmailCheckPasswordLoading());

    final result = await _checkPasswordUseCase.call(password);
    if (result is Success) {
      emit(ChangeEmailCheckPasswordSuccess(result.data));
    } else if (result is Failed) {
      emit(ChangeEmailCheckPasswordFailure(result.data.message));
    }
  }

  Future<void> sendOTP(String token, String newEmail) async {
    emit(ChangeEmailSendOTPLoading());

    final result = await _sendOTPUseCase.call(token, newEmail);
    if (result is Success) {
      emit(ChangeEmailSendOTPSuccess(result.data));
    } else if (result is Failed) {
      emit(ChangeEmailSendOTPFailure(result.data.message));
    }
  }

  Future<void> enterNewEmail(String otp, String newEmail) async {
    emit(ChangeEmailEnterNewEmailLoading());

    final result = await _enterNewEmailUseCase.call(otp, newEmail);
    if (result is Success) {
      emit(ChangeEmailEnterNewEmailSuccess(result.data));
    } else if (result is Failed) {
      emit(ChangeEmailEnterNewEmailFailure(result.data.message));
    }
  }
}
