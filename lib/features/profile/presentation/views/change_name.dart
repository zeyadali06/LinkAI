import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import 'package:linkai/features/profile/presentation/views/widgets/nameWidgets/change_first_name_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/nameWidgets/change_last_name_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../managers/change_name_cubit/change_name_cubit.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  int _selectedIndex = 0;
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autoValidateMode;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late PageController _pageController;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidateMode = AutovalidateMode.disabled;
    firstNameController = TextEditingController(text: UserModel.instance.firstName);
    lastNameController = TextEditingController(text: UserModel.instance.lastName);
    _pageController = PageController();

    _screens = [
      ChangeFirstNameBody(controller: firstNameController),
      ChangeLastNameBody(controller: lastNameController),
    ];
  }

  void _nextPage(BuildContext context, String firstName, String lastName) async {
    if (_selectedIndex < _screens.length - 1) {
      _pageController.animateToPage(
        _selectedIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _selectedIndex++;
      });
    } else {
      ChangeNameCubit cubit = ChangeNameCubit.get(context);
      await cubit.changeName(firstName, lastName);
      if (context.mounted) {
        context.read<ProfileCubit>().updateProfile();
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ChangeNameCubit, ChangeNameState>(
        listener: (context, state) {
          if (state is ChangeNameSuccess) {
            showSnackBar(context, "Name changed successfully", backgroundColor: Colors.green);
            GoRouter.of(context).pop();
          }
          if (state is ChangeNameFailure) {
            showSnackBar(context, state.errorMessage);
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ChangeNameLoading,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).iconTheme.color,
                centerTitle: true,
                title: Text(
                  "Change Name",
                  style: AppStyles.normal18(context),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _nextPage(context, firstNameController.text, lastNameController.text);
                      } else {
                        _autoValidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    child: Text(
                      _selectedIndex + 1 == _screens.length ? "Save" : "Next",
                      style: AppStyles.defaultStyle(context),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: _screens,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
