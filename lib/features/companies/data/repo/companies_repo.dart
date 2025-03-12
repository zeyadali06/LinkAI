import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/companies/domain/repo/companies_repo.dart';

class CompaniesRepoImpl implements CompaniesRepo {
  final ApiManager _apiManager;
  const CompaniesRepoImpl(this._apiManager);

  @override
  Future<RequestResault> getAllCompanies() async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        ApiConstants.companies,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(res["companies"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to fetch companies"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> addCompany(CompanyModel company) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post(
        company.toJson(),
        ApiConstants.companies,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(res['company']);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to add company"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> deleteCompany(String companyId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.delete(
        "${ApiConstants.companies}/$companyId",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to delete company"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
}
