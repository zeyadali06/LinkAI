import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/splash/data/repo/auto_login_repo.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  AutoLoginCubit(this._autoLoginRepo) : super(AutoLoginInitial());
  final AutoLoginRepo _autoLoginRepo;

  Future<void> autoLogin() async {
    emit(AutoLoginLoading());
    final result = await _autoLoginRepo.autoLogin();
    if (result is Success) {
      emit(AutoLoginSuccess());
    } else if (result is Failed) {
      emit(AutoLoginFailure(result.data.message));
    }
  }
}
