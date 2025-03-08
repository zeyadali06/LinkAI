class UserModel {
  const UserModel._();
  static const UserModel _singletonInstance = UserModel._();
  static UserModel get instance => _singletonInstance;

  static void setFromJson(Map<String, dynamic> json) {}
}
