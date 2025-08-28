// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import 'package:restaurant_managment_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';

import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../data/data_source/remote/user_remote_data_source.dart';

class CheckingUserView extends StatefulWidget {
  const CheckingUserView({super.key, required this.info});
  final dynamic info;
  @override
  State<CheckingUserView> createState() => _CheckingUserViewState();
}

class _CheckingUserViewState extends State<CheckingUserView> {
  @override
  void initState() {
    getIt<AuthBloc>().add(
      RegisterUserEvent(
        registerParams: RegisterParams(
          name: widget.info['name'],
          phone: widget.info['phone'],
          password: widget.info['password'],
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadingUserState) {
            EasyLoading.show(status: 'Checking User...');
          }
          if (state is FailedUserState) {
            showSnakbar(state.message);
            context.go('/login');
            EasyLoading.dismiss();
          }
          if (state is LoggedUserState) {
            context.go('/main');
            EasyLoading.dismiss();
          }
        },
        child: Container(color: Colors.white),
      ),
    );
  }
}
