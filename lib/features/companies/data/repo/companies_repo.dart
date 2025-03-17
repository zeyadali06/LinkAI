import 'dart:io';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/companies/domain/repo/companies_repo.dart';

class CompaniesRepoImpl implements CompaniesRepo {
  const CompaniesRepoImpl(this._apiManager);
  final ApiManager _apiManager;

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
  Future<RequestResault> getUserCompanies() async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        ApiConstants.userCompanies,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        List<CompanyModel> companies = [];
        for (var company in res["data"]) {
          companies.add(CompanyModel.fromJson(company));
        }
        return RequestResault.success(companies);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to fetch companies"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        CustomFailure("Something went wrong! ${e.toString()}"),
      );
    }
  }

  @override
  Future<RequestResault> addCompany(CompanyModel company, File? profileImage, File? coverImage) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post(
        company.toJson(),
        ApiConstants.companies,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        CompanyModel company = CompanyModel.fromJson(res['company']);
        try{
        if (profileImage != null) {
           await uploadCompanyLogo(profileImage,company.id!);
        }
        if (coverImage != null) {
           await uploadCompanyCover(coverImage,company.id!);
        }
        }
        // ignore: empty_catches
        catch (e) {}
        return RequestResault.success(company);
      } else {
        return RequestResault.failure(
          CustomFailure("Failed to add company, ${res['message']}"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  Future<RequestResault> uploadCompanyLogo(File? profileImage, String companyId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.uploadFile(
        "${ApiConstants.uploadCompanyLogo}/$companyId",
        profileImage!.path,
        token: UserModel.instance.token,
      );
      if (res["success"]) {
        return RequestResault.success(res["data"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to add company images"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  Future<RequestResault> uploadCompanyCover(File? coverImage, String companyId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.uploadFile(
        "${ApiConstants.uploadCompanyCover}/$companyId",
        coverImage!.path,
        token: UserModel.instance.token,
      );
      if (res["success"]) {
        return RequestResault.success(res["data"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to add company images"),
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
          CustomFailure("Failed to delete company ${res['message']}"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
  @override
  Future<RequestResault> updateCompany(CompanyModel company) async {
    try {
      final Map<String, dynamic> res = await _apiManager.patch(
        company.toJson(),
        "${ApiConstants.companies}/${company.id}",
        token: UserModel.instance.token,
      );
      if (res["success"]) {
        return RequestResault.success(res["data"]);
      } else {
        return RequestResault.failure(
          CustomFailure(res["message"]),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
}
