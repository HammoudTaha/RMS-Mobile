import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/utils/custom_confirm_dialog.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widgets/custom_image_item_shimmer.dart';
import '../widgets/custom_language_dialog.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProfileBloc>().add(LoadProfileEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is LoadedProfileState) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child:
                                state.user.image == null
                                    ? Image.asset(
                                      'assets/images/defualtProfile.png',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                    : CachedNetworkImage(
                                      imageUrl: state.user.image!,
                                      errorWidget:
                                          (context, url, error) => Image.asset(
                                            'assets/images/defualtProfile.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                      placeholder:
                                          (context, url) =>
                                              CustomImageItemShimmer(
                                                height: 80,
                                                width: 80,
                                              ),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                state.user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                state.user.phone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              context.push(
                                '/profile-update',
                                extra: state.user.image,
                              );
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 10, color: Color(0xffE9E7EC)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.notifications,
                            size: 30,
                            color: primary,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: true,
                            activeTrackColor: primary,
                            inactiveThumbColor: primary,
                            onChanged: (value) {},
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.language, size: 30, color: primary),
                          const SizedBox(width: 10),
                          const Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              customLanguageDialog(context);
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          EasyLoading.dismiss();
                          if (state is LoadingUserState) {
                            EasyLoading.show(status: 'loading...');
                          }
                          if (state is FailedUserState) {
                            showSnakbar(state.message);
                            EasyLoading.dismiss();
                          }
                          if (state is LoggedoutUserState) {
                            context.go('/login');
                          }
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 18),
                            const Icon(Icons.logout, size: 30, color: primary),
                            const SizedBox(width: 10),
                            const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                customConfirmDialog(
                                  context,
                                  title: 'Log out',
                                  message: 'Are you sure to log out ?',
                                  onPressed: () async {
                                    getIt<AuthBloc>().add(LogoutUserEvent());
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 30,
                                color: primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is FailedProfileState) {
                  return CustomErrorPage(
                    onRetry: () async {
                      // print(
                      //   await (await getIt<Future<ProfileLocalDataSource>>())
                      //       .getRefreshToken(),
                      // );
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 300),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              },
              buildWhen:
                  (previous, current) =>
                      current is LoadedProfileState ||
                      current is LoadingProfileState ||
                      current is FailedProfileState ||
                      current is InitialProfileState,
            ),
          ),
        ),
      ),
    );
  }
}
