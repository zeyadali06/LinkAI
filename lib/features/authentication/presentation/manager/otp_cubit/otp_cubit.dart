import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._authRepo) : super(OtpInitial());

  final AuthRepo _authRepo;

  Future<void> sendOTP(String email) async {
    emit(OtpLoading());

    RequestResault result = await _authRepo.sendOTP(email);

    if (result is Success) {
      emit(OtpSuccess());
    } else if (result is Failed) {
      emit(OtpFail(result.data.message));
    }
  }
}
