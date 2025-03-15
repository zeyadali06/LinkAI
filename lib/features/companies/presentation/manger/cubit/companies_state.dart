part of 'companies_cubit.dart';

@immutable
sealed class CompaniesState {}

final class CompaniesInitial extends CompaniesState {}

final class CompaniesLoading extends CompaniesState {}

final class CompaniesSuccess extends CompaniesState {
  final List<CompanyModel> companies;
  CompaniesSuccess(this.companies);
}
final class CompanyCreateSuccess extends CompaniesState {
  final CompanyModel company;
  CompanyCreateSuccess(this.company);
}
final class CompaniesFailure extends CompaniesState {
  final String message;
  CompaniesFailure(this.message);
}
final class CompanyUpdateSuccess extends CompaniesState {

  CompanyUpdateSuccess();
}
final class CompanyUpdateFailure extends CompaniesState {
  final String message;
  CompanyUpdateFailure(this.message);
}
final class CompanyDeleteSuccess extends CompaniesState {
  CompanyDeleteSuccess();
}
final class CompanyDeleteFailure extends CompaniesState {
  final String message;
  CompanyDeleteFailure(this.message);
}
