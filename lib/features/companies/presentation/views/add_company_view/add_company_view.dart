import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/companies/presentation/views/add_company_view/widgets/add_company_body.dart';

class AddCompanyView extends StatelessWidget {
  const AddCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<CompaniesCubit>().getUserCompanies();
            GoRouter.of(context).pop();
          },
        ),
        title: const Text('Add Company'),
        centerTitle: true,
      ),
      body: const AddCompanyBody(),
    );
  }
}
