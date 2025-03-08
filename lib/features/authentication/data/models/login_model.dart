class LoginModel {
  final String email;
  final String password;

  const LoginModel({
    required this.email,
    required this.password,
  });

  static const String emailKey = 'email';
  static const String passwordKey = 'password';

  Map<String, dynamic> toJson() {
    return {
      emailKey: email,
      passwordKey: password,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json[emailKey],
      password: json[passwordKey],
    );
  }
}
