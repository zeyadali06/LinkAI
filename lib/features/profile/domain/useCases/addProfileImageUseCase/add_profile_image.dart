import 'package:image_picker/image_picker.dart';
import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';

class AddProfileImageUseCase {
  final ProfileRepo _profileRepo;

  AddProfileImageUseCase(this._profileRepo);

  Future<RequestResault> call(XFile? profileImage) async {
    return await _profileRepo.addProfileImage(profileImage);
  }
}
