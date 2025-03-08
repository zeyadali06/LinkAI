class RegisterModel {
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String otp;
  final String firstName;
  final String lastName;

  const RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.otp,
    required this.firstName,
    required this.lastName,
  });

  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static const String confirmPasswordKey = 'cPassword';
  static const String phoneNumberKey = 'mobileNumber';
  static const String otpKey = "otp";
  static const String firstNameKey = "firstName";
  static const String lastNameKey = "lastName";

  Map<String, dynamic> toJson() {
    return {
      emailKey: email,
      passwordKey: password,
      confirmPasswordKey: confirmPassword,
      phoneNumberKey: phoneNumber,
      firstNameKey: firstName,
      lastNameKey: lastName,
      otpKey: otp,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json[emailKey],
      password: json[passwordKey],
      confirmPassword: json[confirmPasswordKey],
      phoneNumber: json[phoneNumberKey],
      firstName: json[firstNameKey],
      lastName: json[lastNameKey],
      otp: json[otpKey],
    );
  }
}
