import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/companies/presentation/views/user_companies_view/widgets/all_companies_view_body.dart';

class AllCompaniesView extends StatelessWidget {
  const AllCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(UserModel.instance.token);
    return BlocProvider(
      create: (context) => CompaniesCubit()..getUserCompanies(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("All Companies"),
            ),
            body: const AllCompaniesViewBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.addCompanyView, extra: context.read<CompaniesCubit>());
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
