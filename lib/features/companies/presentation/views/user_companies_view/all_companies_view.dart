import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/companies/presentation/views/user_companies_view/widgets/all_companies_view_body.dart';

class AllCompaniesView extends StatelessWidget {
  const AllCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompaniesCubit()..getUserCompanies(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).iconTheme.color,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: Text(
                "User Companies",
                style: AppStyles.semiBold18(context),
              ),
            ),
            body: const AllCompaniesViewBody(),
            floatingActionButton: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).filledButtonTheme.style!.backgroundColor!.resolve({}),
              onPressed: () {
                GoRouter.of(context).push(AppRouter.addCompanyView, extra: context.read<CompaniesCubit>());
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).filledButtonTheme.style!.foregroundColor!.resolve({}),
              ),
            ),
          );
        },
      ),
    );
  }
}
