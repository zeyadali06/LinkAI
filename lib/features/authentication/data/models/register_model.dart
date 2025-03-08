class RegisterModel {
  String? email;
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  String? otp;
  String? firstName;
  String? lastName;

  RegisterModel({
    this.email,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.otp,
    this.firstName,
    this.lastName,
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
