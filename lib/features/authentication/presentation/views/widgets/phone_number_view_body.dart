import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/country_model.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/auth_text_field.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/countries_code_menu.dart';

class PhoneNumberViewBody extends StatefulWidget {
  const PhoneNumberViewBody({super.key});

  @override
  State<PhoneNumberViewBody> createState() => _PhoneNumberViewBodyState();
}

class _PhoneNumberViewBodyState extends State<PhoneNumberViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late final TextEditingController phoneController;
  late Country countryCode;
  late String phone;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidatemodel,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 68,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          SizedBox(
                            child: CountriesCodeMenu(
                              onChanged: (country) {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AuthTextField(
                              hintText: "Phone Number",
                              controller: phoneController,
                              cursorColor: Colors.grey,
                              hintColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.validate();
                      } else {
                        autovalidatemodel = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
