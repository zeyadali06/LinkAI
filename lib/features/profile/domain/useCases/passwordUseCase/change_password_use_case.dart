import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';

class ChangePasswordUseCase {
  final ProfileRepo _profileRepo;
  ChangePasswordUseCase(this._profileRepo);
  Future<RequestResault> call(String oldPassword, String newPassword) async {
    return await _profileRepo.changePassword(oldPassword, newPassword);
  }
}
