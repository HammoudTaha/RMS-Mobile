import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../data/data_source/remote/user_remote_data_source.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/custom_input_item.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({super.key, required this.isRegister, this.info});
  final bool isRegister;
  final dynamic info;

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formStateKey = GlobalKey();
  late final AnimationController controller;
  String? d1, d2, d3, d4;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
    super.initState();
  }

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
          formStateKey.currentState!.reset();
          EasyLoading.dismiss();
        }
        if (state is ForgetPasswordUserState) {
          showSnakbar(state.message);
        }
        if (state is SentVerificationCodeState) {
          showSnakbar(state.message);
        }
        if (state is VerifiedPhoneUserState) {
          if (widget.isRegister) {
            context.go('/checking-user', extra: widget.info);
          } else {
            final code = '$d1$d2$d3$d4';
            context.go(
              '/reset-password',
              extra: {'phone': widget.info['phone'], 'code': code},
            );
          }
          formStateKey.currentState!.reset();
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
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formStateKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'verify_title'.tr(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'verify_subtitle'.tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(height: 100),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      CustomAnimatedInputItem(
                        controller: controller,
                        onSave: (value) {
                          d1 = value;
                        },
                      ),
                      const SizedBox(width: 40),
                      CustomAnimatedInputItem(
                        controller: controller,
                        onSave: (value) {
                          d2 = value;
                        },
                      ),
                      const SizedBox(width: 40),
                      CustomAnimatedInputItem(
                        controller: controller,
                        onSave: (value) {
                          d3 = value;
                        },
                      ),
                      const SizedBox(width: 40),
                      CustomAnimatedInputItem(
                        controller: controller,
                        onSave: (value) {
                          d4 = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomAnimatedButton(
                    text: 'verify_label'.tr(),
                    onClick: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState!.save();
                        final code = '$d1$d2$d3$d4';
                        if (widget.isRegister) {
                          getIt<AuthBloc>().add(
                            VerifyPhoneUserEvent(
                              VerifyPhoneParams(
                                phone: widget.info['phone'],
                                code: code,
                              ),
                            ),
                          );
                        } else {
                          getIt<AuthBloc>().add(
                            VerifyResetCodeEvent(
                              VerifyPhoneParams(
                                phone: widget.info['phone'],
                                code: code,
                              ),
                            ),
                          );
                        }
                      } else {
                        controller.forward();
                      }
                    },
                  ),
                  const SizedBox(height: 50),

                  Center(
                    child: const Text(
                      "Didn't receive any code ?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (widget.isRegister) {
                          getIt<AuthBloc>().add(
                            SendVerificationCodeUserEvent(widget.info['phone']),
                          );
                        } else {
                          getIt<AuthBloc>().add(
                            ForgetPasswordUserEvent(widget.info['phone']),
                          );
                        }
                      },
                      child: const Text(
                        "Resend new code",
                        style: TextStyle(
                          fontSize: 16,
                          color: primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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

class CustomAnimatedInputItem extends StatefulWidget {
  const CustomAnimatedInputItem({
    super.key,
    required this.controller,
    required this.onSave,
  });
  final AnimationController controller;
  final void Function(String?) onSave;
  @override
  State<CustomAnimatedInputItem> createState() =>
      _CustomAnimatedInputItemState();
}

class _CustomAnimatedInputItemState extends State<CustomAnimatedInputItem>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  @override
  void initState() {
    animation = Tween<double>(begin: 0, end: -.1).animate(widget.controller);
    widget.controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final shake = sin(animation.value * 2 * pi * 4) * 4;
        return Transform.translate(
          offset: Offset(shake, shake),
          child: CustomIntputItem(onSave: widget.onSave),
        );
      },
    );
  }
}
