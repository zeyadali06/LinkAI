import 'dart:io';

import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/company_model.dart';


abstract class CompaniesRepo {
  Future<RequestResault> getAllCompanies();
  Future<RequestResault> addCompany(CompanyModel company, File? profileImage, File? coverImage);
  Future<RequestResault> deleteCompany(String companyId);
  Future<RequestResault> getUserCompanies();
  Future<RequestResault> updateCompany(CompanyModel company);
}

