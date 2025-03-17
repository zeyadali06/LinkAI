import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditCompanyViewBody extends StatefulWidget {
  const EditCompanyViewBody({super.key, required this.companyModel});
  final CompanyModel companyModel;

  @override
  State<EditCompanyViewBody> createState() => _EditCompanyViewBodyState();
}

class _EditCompanyViewBodyState extends State<EditCompanyViewBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController industryController;
  late TextEditingController minEmployeesController;
  late TextEditingController maxEmployeesController;
  final TextEditingController _hrEmailController = TextEditingController();
  final List<String> _hrEmails = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    nameController =
        TextEditingController(text: widget.companyModel.companyName);
    descriptionController =
        TextEditingController(text: widget.companyModel.description);
    emailController =
        TextEditingController(text: widget.companyModel.companyEmail);
    addressController =
        TextEditingController(text: widget.companyModel.address);
    industryController =
        TextEditingController(text: widget.companyModel.industry);
    minEmployeesController = TextEditingController(
        text: widget.companyModel.minEmployees.toString());
    maxEmployeesController = TextEditingController(
        text: widget.companyModel.maxEmployees.toString());
    _hrEmails
        .addAll(widget.companyModel.HRs); // Initialize with existing HRs
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    addressController.dispose();
    industryController.dispose();
    minEmployeesController.dispose();
    maxEmployeesController.dispose();
    _hrEmailController.dispose();
    super.dispose();
  }

  void _addHrEmail() {
    if (_hrEmailController.text.isNotEmpty) {
      setState(() {
        _hrEmails.add(_hrEmailController.text);
        _hrEmailController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CompaniesCubit>();
    return BlocConsumer<CompaniesCubit, CompaniesState>(
      listener: (context, state) {
        if (state is CompanyUpdateSuccess) {
          GoRouter.of(context).pop();
        }
        if (state is CompanyUpdateFailure ) {
          showSnackBar(context, state.message);
        }
        if (state is CompanyDeleteSuccess) {
          GoRouter.of(context).pop();
        }
        if (state is CompanyDeleteFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CompaniesLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Company Name',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 3,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Company Email',
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Please enter email';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: addressController,
                    hintText: 'Address',
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Please enter address';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: industryController,
                    hintText: 'Industry',
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Please enter industry';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: minEmployeesController,
                          hintText: 'Min Employees',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Required';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: maxEmployeesController,
                          hintText: 'Max Employees',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Required';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _hrEmailController,
                          hintText: 'HR Email',
                          keyboardType: TextInputType.emailAddress,
                          enableValidator: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addHrEmail,
                        child: const Text('Add HR'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _hrEmails
                        .map((email) => Chip(
                              label: Text(email),
                              onDeleted: () {
                                setState(() {
                                  _hrEmails.remove(email);
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Update Company',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedCompany = widget.companyModel.copyWith(
                          companyName: nameController.text,
                          description: descriptionController.text,
                          companyEmail: emailController.text,
                          address: addressController.text,
                          industry: industryController.text,
                          minEmployees:
                              int.tryParse(minEmployeesController.text) ?? 0,
                          maxEmployees:
                              int.tryParse(maxEmployeesController.text) ?? 0,
                          HRs: _hrEmails,
                        );
                        context
                            .read<CompaniesCubit>()
                            .updateCompany( updatedCompany);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Delete Company',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Company'),
                          content: const Text('Are you sure you want to delete this company?'),
                          actions: [
                            TextButton(
                              onPressed: () => GoRouter.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.deleteCompany(widget.companyModel.id!);
                                GoRouter.of(context).pop(); // Close dialog
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    textColor: Colors.white,
                    buttonColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
