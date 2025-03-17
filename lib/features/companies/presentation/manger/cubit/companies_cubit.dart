import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/features/companies/domain/repo/companies_repo.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {

  CompaniesCubit() : super(CompaniesInitial());
  final _companiesRepo = ServiceLocator.getIt<CompaniesRepo>();
  final List<CompanyModel> userCompanies = [];
  Future<void> createCompany(CompanyModel company, File? profileImage, File? coverImage) async {
    emit(CompaniesLoading());
    final result = await _companiesRepo.addCompany(company, profileImage, coverImage);
    if (result is Success) {
      emit(CompanyCreateSuccess(result.data));
    } else if (result is Failed) {
      emit(CompaniesFailure(result.data.message));
    }
  }

  Future<void> getUserCompanies() async {
    emit(CompaniesLoading());
    final result = await _companiesRepo.getUserCompanies();
    if (result is Success) {
      emit(CompaniesSuccess(result.data));
      userCompanies.clear();
      userCompanies.addAll(result.data);
    } else if (result is Failed) {
      emit(CompaniesFailure(result.data.message));
    }
  }
 Future<void> updateCompany(CompanyModel company) async {
    emit(CompaniesLoading());
    final result = await _companiesRepo.updateCompany(company);
    if (result is Success) {
     final index = userCompanies.indexWhere((element) => element.id == company.id);
     if (index != -1) {
       userCompanies[index].setFrom(company);
     }
      emit(CompanyUpdateSuccess());
    } else if (result is Failed) {
      emit(CompanyUpdateFailure(result.data.message));
    }
  }
  Future<void> deleteCompany(String companyId) async {
    emit(CompaniesLoading());
    final result = await _companiesRepo.deleteCompany(companyId);
    if (result is Success) {
      emit(CompanyDeleteSuccess());
      userCompanies.removeWhere((element) => element.id == companyId);
    } else if (result is Failed) {
      emit(CompanyDeleteFailure(result.data.message));
    }
  }
  
}
