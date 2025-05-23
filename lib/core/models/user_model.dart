import 'package:linkai/core/enums/role_enum.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? token;
  String? profileImage;
  Role? role;

  UserModel._();
  static final UserModel _singletonInstance = UserModel._();
  static UserModel get instance => _singletonInstance;

  void setFromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phone = json["mobileNumber"];
    profileImage = json["profilePic"]?["secure_url"];
    role = Role.fromString(json["role"]);
  }
}
