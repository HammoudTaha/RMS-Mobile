import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/extensions/validator_extension.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';
import '../../../../core/widgets/custom_animated_button.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> formStateKey = GlobalKey();
  String? phone;
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
        if (state is ForgetPasswordUserState) {
          context.push(
            '/confirmation',
            extra: {
              'is_register': false,
              'info': {'phone': phone},
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formStateKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  Text(
                    'forget_title'.tr(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'forget_subtitle'.tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 100),

                  Text('phone_label'.tr(), style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  AuthTextFormField(
                    hint: 'phone_hint'.tr(),
                    preIcon: Icons.phone,
                    onSave: (value) {
                      phone = value;
                    },
                    keyboardType: TextInputType.phone,
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
                  const SizedBox(height: 50),
                  CustomAnimatedButton(
                    text: 'continue_label'.tr(),
                    onClick: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState!.save();
                        getIt<AuthBloc>().add(ForgetPasswordUserEvent(phone!));
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
