import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepo) : super(RegisterInitial());

  final AuthRepo _authRepo;

  Future<void> register(AuthModel authModel) async {
    emit(RegisterLoading());

    final RequestResault result = await _authRepo.register(authModel);

    if (result is Success) {
      emit(RegisterSuccess());
    } else if (result is Failed) {
      emit(RegisterFailed(result.data.message));
    }
  }
}
