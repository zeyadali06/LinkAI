import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/country_model.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';

class PhoneNumberViewBody extends StatefulWidget {
  const PhoneNumberViewBody({super.key});

  @override
  State<PhoneNumberViewBody> createState() => _PhoneNumberViewBodyState();
}

class _PhoneNumberViewBodyState extends State<PhoneNumberViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late Country countryCode;
  late String phone;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    super.initState();
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
                  Text(
                    "Phone Number",
                    style: AppStyles.normal18(context),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 68,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          // SizedBox(
                          //   child: CountriesCodeMenu(
                          //     onChanged: (country) {
                          //       countryCode = country;
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              validator: (value) {
                                if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value!)) {
                                  return "Enter valid phone number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                // ServiceLocator.getIt<RegisterModel>().phoneNumber = "${countryCode.code}$value";
                                ServiceLocator.getIt<AuthModel>().phoneNumber = value;
                              },
                              inputFormatters: [Formatters.numbersOnlyFormatter],
                              hintText: "Phone Number",
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
                        _formKey.currentState!.save();
                        await BlocProvider.of<OtpCubit>(context).sendOTP(ServiceLocator.getIt<AuthModel>().email!);
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
