import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login(LoginModel loginModel) async {
    emit(LoginLoading());

    RequestResault result = await _authRepo.login(loginModel);

    if (result is Success) {
      emit(LoginSuccess());
    } else if (result is Failed) {
      emit(CompleteRegister());
    }
  }
}
