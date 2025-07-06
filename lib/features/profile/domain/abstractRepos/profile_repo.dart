import 'package:image_picker/image_picker.dart';
import '../../../../core/failures/request_result.dart';

abstract class ProfileRepo {
  const ProfileRepo();

  Future<RequestResault> changeName(String firstName, String lastName);
  Future<RequestResault> changePassword(String oldPassword, String newPassword);
  Future<RequestResault> addProfileImage(XFile? profileImage);
  Future<RequestResault> deleteProfileImage();
  Future<RequestResault> changeEmailCheckPassword(String pass);
  Future<RequestResault> changeEmailSendOTP(String token, String newEmail);
  Future<RequestResault> changeEmailEnterNewEmail(String otp, String newEmail);
}
