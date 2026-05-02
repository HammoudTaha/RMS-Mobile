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

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, this.info});
  final dynamic info;
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> formStateKey = GlobalKey();
  String? newPassword;
  String? confirmPassword;
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
        if (state is ResetedPasswordUserState) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go('/login');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
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
                    'reset_title'.tr(),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'reset_subtitle'.tr(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'new_password_label'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  AuthTextFormField(
                    hint: 'new_password_hint'.tr(),
                    preIcon: Icons.security,
                    visibile: true,
                    onSave: (value) {
                      newPassword = value;
                    },
                    validator: (value) {
                      if (value?.replaceAll(' ', '').isEmpty ?? true) {
                        return "password can't be empty";
                      } else if (!value!.isPasswordValid) {
                        return 'password must be at 5 character';
                      } else {
                        formStateKey.currentState?.save();
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'confirm_password_label'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  AuthTextFormField(
                    hint: 'confirm_password_hint'.tr(),
                    preIcon: Icons.security,
                    visibile: true,
                    onSave: (value) {
                      confirmPassword = value;
                    },
                    validator: (value) {
                      if (!newPassword!.isPasswordValid) {
                        return null;
                      } else {
                        if (value?.replaceAll(' ', '').isEmpty ?? true) {
                          return "confirm Password can't be empty";
                        } else if (value != newPassword) {
                          return 'Password not matched';
                        }
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 100),
                  CustomAnimatedButton(
                    text: 'set_label'.tr(),
                    onClick: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState?.save();
                        getIt<AuthBloc>().add(
                          ResetPasswordUserEvent(
                            ResetPasswordParams(
                              code: widget.info['code'],
                              newPassword: newPassword!,
                              phone: widget.info['phone'],
                            ),
                          ),
                        );
                      }
                    },
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
