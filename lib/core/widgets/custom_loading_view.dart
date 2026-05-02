import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/data_source/local/user_local_data_source.dart';
import '../services/di/service_locator.dart';

class CustomLoadingView extends StatefulWidget {
  const CustomLoadingView({super.key});

  @override
  State<CustomLoadingView> createState() => _CustomLoadingViewState();
}

class _CustomLoadingViewState extends State<CustomLoadingView> {
  @override
  void initState() {
    check();
    super.initState();
  }

  void check() async {
    if (await (await getIt<Future<UserLocalDataSource>>()).getIsLogedInUser()) {
      () {
        context.go('/main');
      }();
    } else {
      () {
        context.go('/login');
      }();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
