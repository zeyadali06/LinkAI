import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';

class ChangeEmailEnterNewEmailUseCase {
  final ProfileRepo _profileRepo;

  ChangeEmailEnterNewEmailUseCase(this._profileRepo);

  Future<RequestResault> call(String otp, String newEmail) async {
    return await _profileRepo.changeEmailEnterNewEmail(otp, newEmail);
  }
}
