import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';

class ChangeEmailCheckPasswordUseCase {
  final ProfileRepo _profileRepo;

  ChangeEmailCheckPasswordUseCase(this._profileRepo);

  Future<RequestResault> call(String password) async {
    return await _profileRepo.changeEmailCheckPassword(password);
  }
}
