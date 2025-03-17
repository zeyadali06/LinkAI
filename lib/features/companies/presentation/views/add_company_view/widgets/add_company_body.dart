import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddCompanyBody extends StatefulWidget {
  const AddCompanyBody({super.key});

  @override
  State<AddCompanyBody> createState() => _AddCompanyBodyState();
}

class _AddCompanyBodyState extends State<AddCompanyBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _minEmployeesController = TextEditingController();
  final TextEditingController _maxEmployeesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final List<String> _hrEmails = [];
  final TextEditingController _hrEmailController = TextEditingController();

  File? _profileImage;
  File? _coverImage;

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _industryController.dispose();
    _addressController.dispose();
    _minEmployeesController.dispose();
    _maxEmployeesController.dispose();
    _emailController.dispose();
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

  Future<void> _pickImage(bool isProfile) async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
    } catch (_) {}
    if (image != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(image!.path);
        } else {
          _coverImage = File(image!.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompaniesCubit, CompaniesState>(
      listener: (context, state) {
        if (state is CompanyCreateSuccess) {
          context.read<CompaniesCubit>().getUserCompanies();
          GoRouter.of(context).pop();
        } else if (state is CompaniesFailure) {
          isLoading = false;
          showSnackBar(context, state.message);
        } else if (state is CompaniesLoading) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _pickImage(false),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                                image: _coverImage != null
                                    ? DecorationImage(
                                        image: FileImage(_coverImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _coverImage == null
                                  ? const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 40,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 30), // Space for profile picture overflow
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _pickImage(true),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                              child: _profileImage == null
                                  ? const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 30,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Company Name',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: 'Description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _industryController,
                    hintText: 'Industry',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _addressController,
                    hintText: 'Address',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _minEmployeesController,
                          hintText: 'Min Employees',
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: _maxEmployeesController,
                          hintText: 'Max Employees',
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Company Email',
                    keyboardType: TextInputType.emailAddress,
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
                      CustomButton(
                        fitWidth: false,
                        fontSize: 16,
                        text: 'Add HR',
                        onPressed: _addHrEmail,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _hrEmails
                        .map(
                          (email) => Chip(
                            color: WidgetStatePropertyAll(Theme.of(context).inputDecorationTheme.fillColor!),
                            label: Text(email),
                            onDeleted: () {
                              setState(() {
                                _hrEmails.remove(email);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Add Company',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final CompanyModel company = CompanyModel(
                            companyName: _nameController.text,
                            description: _descriptionController.text,
                            industry: _industryController.text,
                            address: _addressController.text,
                            companyEmail: _emailController.text,
                            HRs: _hrEmails,
                            minEmployees: int.parse(_minEmployeesController.text),
                            maxEmployees: int.parse(_maxEmployeesController.text),
                          );
                          BlocProvider.of<CompaniesCubit>(context).createCompany(
                            company,
                            _profileImage,
                            _coverImage,
                          );
                        }
                      },
                    ),
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
