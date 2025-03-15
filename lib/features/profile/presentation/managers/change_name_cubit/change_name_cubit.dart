import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/failures/request_result.dart';
import '../../../domain/useCases/changeNameuseCase/change_name_use_case.dart';

part 'change_name_state.dart';
@injectable
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
