import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/extensions/validator_extension.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';
import '../../../../core/constants/colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formStateKey = GlobalKey();
  String? name;
  String? phone;
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is LoadingUserState) {
          EasyLoading.show(status: 'loading...');
        }
        if (state is FailedUserState) {
          showSnakbar(state.message);
          EasyLoading.dismiss();
        }
        if (state is SentVerificationCodeState) {
          context.push(
            '/confirmation',
            extra: {
              'is_register': true,
              'info': {'name': name, 'phone': phone, 'password': password},
            },
          );
          formStateKey.currentState!.reset();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formStateKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    "register_title".tr(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "register_subtitle".tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Text("name_label".tr(), style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: "name_hint".tr(),
                    preIcon: Icons.person,
                    onSave: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value?.replaceAll(' ', '').isEmpty ?? true) {
                        return "name can't be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "phone_label".tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: "phone_hint".tr(),
                    preIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    onSave: (value) {
                      phone = value;
                    },
                    validator: (value) {
                      if (value?.replaceAll(' ', '').isEmpty ?? true) {
                        return "phone can't be empty";
                      } else if (!value!.isPhoneValid) {
                        return 'invalid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "password_label".tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: "password_hint".tr(),
                    preIcon: Icons.security,
                    visibile: true,
                    onSave: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value?.replaceAll(' ', '').isEmpty ?? true) {
                        return "password can't be empty";
                      } else if (!value!.isPasswordValid) {
                        return 'password must be at 5 character';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  CustomAnimatedButton(
                    text: "sign_up".tr(),
                    onClick: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState!.save();
                        getIt<AuthBloc>().add(
                          SendVerificationCodeUserEvent(phone!),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "have_account".tr(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          "sign_in".tr(),
                          style: const TextStyle(fontSize: 18, color: primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
