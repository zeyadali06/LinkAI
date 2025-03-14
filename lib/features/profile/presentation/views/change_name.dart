import 'package:flutter/material.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/profile/presentation/views/widgets/change_first_name_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/change_last_name_body.dart';

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

  void _nextPage() {
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
      // TODO: Handle Save Logic
      Navigator.pop(context);
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Change Name"),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              onPressed: ()  {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                _nextPage();
                } else {
                  _autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              child: Text(
                _selectedIndex + 1 == _screens.length ? "Save" : "Next",
                style: AppStyles.normal18(context, Colors.white),
              ),
            )
          ],
        ),
        body: Form(
          key:_formKey ,
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
  }
}
