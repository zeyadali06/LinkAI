part of 'change_name_cubit.dart';

@immutable
sealed class ChangeNameState {}

final class ChangeNameInitial extends ChangeNameState {}

final class ChangeNameLoading extends ChangeNameState {}

final class ChangeNameSuccess extends ChangeNameState {}

final class ChangeNameFailure extends ChangeNameState {
  final String errorMessage;
  ChangeNameFailure(this.errorMessage);
}
