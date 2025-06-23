import 'dart:io';

import '../../../../core/failures/request_result.dart';

abstract class JobDetailsRepo {
  Future<File> pickCv();

  Future<RequestResault> uploadCv(String id,File cv);
  Future<RequestResault> getApplicationStatus(String id);

}
