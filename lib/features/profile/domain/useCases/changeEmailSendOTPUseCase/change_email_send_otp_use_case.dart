import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';

class ChangeEmailSendOTPUseCase {
  final ProfileRepo _profileRepo;

  ChangeEmailSendOTPUseCase(this._profileRepo);

  Future<RequestResault> call(String token, String newEmail) async {
    return await _profileRepo.changeEmailSendOTP(token, newEmail);
  }
}
