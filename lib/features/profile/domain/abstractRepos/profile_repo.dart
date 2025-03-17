import 'package:image_picker/image_picker.dart';
import '../../../../core/failures/request_result.dart';

abstract class ProfileRepo {
  const ProfileRepo();

  Future<RequestResault> changeName(String firstName, String lastName);
  Future<RequestResault> changePassword(String oldPassword, String newPassword);
  Future<RequestResault> addProfileImage(XFile? profileImage);
}
