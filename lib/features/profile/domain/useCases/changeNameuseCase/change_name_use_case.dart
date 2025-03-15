import 'package:injectable/injectable.dart';

import '../../../../../core/failures/request_result.dart';
import '../../abstractRepos/profile_repo.dart';


class ChangeNameUseCase {
  final ProfileRepo _profileRepo ;
  ChangeNameUseCase(this._profileRepo);
  Future<RequestResault>call (String firstName, String lastName) async{
    return await _profileRepo.changeName(firstName, lastName);
  }
}