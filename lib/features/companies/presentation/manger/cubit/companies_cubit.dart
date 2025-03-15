import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/features/companies/domain/repo/companies_repo.dart';
import 'package:meta/meta.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(CompaniesInitial());
  final _companiesRepo = ServiceLocator.getIt<CompaniesRepo>();

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
    } else if (result is Failed) {
      emit(CompaniesFailure(result.data.message));
    }
  }
}
