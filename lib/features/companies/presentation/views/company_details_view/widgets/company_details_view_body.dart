import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/companies/presentation/views/company_details_view/widgets/details_section.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_list.dart';

class CompanyDetailsViewBody extends StatelessWidget {
  const CompanyDetailsViewBody({super.key, required this.company});

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                                image: company.coverImage != null
                                    ? DecorationImage(
                                        image: NetworkImage(company.coverImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: company.coverImage == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 40,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    child: company.profileImage != null
                                        ? Image.network(
                                            company.profileImage!,
                                            fit: BoxFit.fill,
                                            width: 100,
                                            height: 100,
                                          )
                                        : const Icon(
                                            Icons.photo,
                                            size: 30,
                                            color: Colors.grey,
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(
                                    company.companyName,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TabBar(
                      labelColor: Theme.of(context).textTheme.bodyLarge!.color,
                      indicatorColor: Theme.of(context).textTheme.bodyLarge!.color,
                      overlayColor: WidgetStatePropertyAll(Colors.grey.withValues(alpha: .2)),
                      tabs: const [
                        Tab(text: 'Company Details'),
                        Tab(text: 'Company Jobs'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          // Company Details Tab
                          DetailsSection(company: company),
                          // Company Jobs Tab - To be implemented later
                          JobsListPage(companyModel: company)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Theme.of(context).filledButtonTheme.style!.backgroundColor!.resolve({}),
            onPressed: () {
              GoRouter.of(context).push(
                AppRouter.createJobView,
                extra: company,
              );
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).filledButtonTheme.style!.foregroundColor!.resolve({}),
            ),
          ),
        ),
      ],
    );
  }
}
