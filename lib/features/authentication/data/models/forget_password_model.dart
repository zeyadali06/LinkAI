class ForgetPasswordModel {
  final String email;
  final String otp;
  final String newPassword;

  const ForgetPasswordModel({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  static const String emailKey = "email";
  static const String otpKey = "otp";
  static const String newPasswordKey = "password";
}
