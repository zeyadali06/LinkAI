enum Role {
  hr,
  user;

  static Role fromString(String value) {
    switch (value) {
      case RoleExtension._user:
        return Role.user;
      case RoleExtension._hr:
        return Role.hr;
      default:
        return Role.user;
    }
  }
}

extension RoleExtension on Role {
  static const String _user = "User";
  static const String _hr = "Company_owner";

  String get label {
    switch (this) {
      case Role.user:
        return _user;
      case Role.hr:
        return _hr;
    }
  }
}
