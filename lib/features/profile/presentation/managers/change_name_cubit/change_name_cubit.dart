import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failures/request_result.dart';
import '../../../domain/useCases/changeNameuseCase/change_name_use_case.dart';

part 'change_name_state.dart';

class ChangeNameCubit extends Cubit<ChangeNameState> {
  final ChangeNameUseCase _changeNameUseCase;

  ChangeNameCubit(this._changeNameUseCase) : super(ChangeNameInitial());
  static ChangeNameCubit get(context) => BlocProvider.of(context);

  Future<void> changeName(String firstName, String lastName) async {
    emit(ChangeNameLoading());

    final result = await _changeNameUseCase.call(firstName, lastName);
    if (result is Success) {
      emit(ChangeNameSuccess());
    } else if (result is Failed) {
      emit(ChangeNameFailure(result.data.message));
    }
  }
}
