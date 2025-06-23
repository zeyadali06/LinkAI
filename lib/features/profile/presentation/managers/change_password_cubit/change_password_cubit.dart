import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/failures/request_result.dart';
import '../../../domain/useCases/passwordUseCase/change_password_use_case.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase) : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoading());
    final result = await _changePasswordUseCase.call(oldPassword, newPassword);
    if (result is Success) {
      emit(ChangePasswordSuccess());
    } else if (result is Failed) {
      emit(ChangePasswordFailure(errorMessage: result.data!.message));
    }
  }
}
