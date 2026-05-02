import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/validator_extension.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../data/data_source/remote/user_remote_data_source.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/constants/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formStateKey = GlobalKey();
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
        if (state is LoggedUserState) {
          context.go('/main');
          EasyLoading.dismiss();
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
                    'login_title'.tr(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'login_subtitle'.tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'phone_label'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: 'phone_hint'.tr(),
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
                    'password_label'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: 'password_hint'.tr(),
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
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context.push('/forget-password');
                        },
                        child: Text(
                          'forget_password'.tr(),
                          style: const TextStyle(
                            color: primary,
                            decoration: TextDecoration.underline,
                            decorationColor: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomAnimatedButton(
                    text: 'sign_in'.tr(),
                    onClick: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState!.save();
                        getIt<AuthBloc>().add(
                          LoginUserEvent(
                            loginParams: LoginParams(
                              phone: phone!,
                              passwrod: password!,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'not_have_account'.tr(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/register');
                        },
                        child: Text(
                          'sign_up'.tr(),
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
