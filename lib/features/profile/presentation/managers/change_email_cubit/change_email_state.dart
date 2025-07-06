part of 'change_email_cubit.dart';

@immutable
sealed class ChangeEmailState {}

final class ChangeEmailInitial extends ChangeEmailState {}

// Check Password States
final class ChangeEmailCheckPasswordLoading extends ChangeEmailState {}

final class ChangeEmailCheckPasswordSuccess extends ChangeEmailState {
  final String token;
  ChangeEmailCheckPasswordSuccess(this.token);
}

final class ChangeEmailCheckPasswordFailure extends ChangeEmailState {
  final String errorMessage;
  ChangeEmailCheckPasswordFailure(this.errorMessage);
}

// Send OTP States
final class ChangeEmailSendOTPLoading extends ChangeEmailState {}

final class ChangeEmailSendOTPSuccess extends ChangeEmailState {
  final String message;
  ChangeEmailSendOTPSuccess(this.message);
}

final class ChangeEmailSendOTPFailure extends ChangeEmailState {
  final String errorMessage;
  ChangeEmailSendOTPFailure(this.errorMessage);
}

// Enter New Email States
final class ChangeEmailEnterNewEmailLoading extends ChangeEmailState {}

final class ChangeEmailEnterNewEmailSuccess extends ChangeEmailState {
  final String message;
  ChangeEmailEnterNewEmailSuccess(this.message);
}

final class ChangeEmailEnterNewEmailFailure extends ChangeEmailState {
  final String errorMessage;
  ChangeEmailEnterNewEmailFailure(this.errorMessage);
}
