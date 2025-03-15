part of 'auto_login_cubit.dart';

@immutable
sealed class AutoLoginState {}

final class AutoLoginInitial extends AutoLoginState {}

final class AutoLoginLoading extends AutoLoginState {}

final class AutoLoginSuccess extends AutoLoginState {}

final class AutoLoginFailure extends AutoLoginState {
  final String message;

  AutoLoginFailure(this.message);
}
