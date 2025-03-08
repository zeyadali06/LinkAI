import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepo) : super(RegisterInitial());

  final AuthRepo _authRepo;

  Future<void> register(RegisterModel registerModel) async {
    emit(RegisterLoading());

    final RequestResault result = await _authRepo.register(registerModel);

    if (result is Success) {
      emit(RegisterSuccess());
    } else if (result is Failed) {
      emit(RegisterFailed(result.data.message));
    }
  }
}
