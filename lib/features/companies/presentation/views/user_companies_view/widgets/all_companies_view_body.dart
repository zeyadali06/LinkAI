import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/companies/presentation/views/user_companies_view/widgets/company_card.dart';

class AllCompaniesViewBody extends StatelessWidget {
  const AllCompaniesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompaniesCubit, CompaniesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is CompaniesSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return CompanyCard(companyModel: state.companies[index]);
            },
            itemCount: state.companies.length);
        }
        else if (state is CompaniesFailure) {
          return Center(child: Text(state.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
