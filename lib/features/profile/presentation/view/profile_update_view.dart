import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../auth/presentation/widgets/auth_text_form_field.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widgets/custom_image_item_shimmer.dart';
import '../widgets/custom_profile_image.dart';

class ProfileUpdateView extends StatefulWidget {
  const ProfileUpdateView({super.key, required this.image});
  final String? image;

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  String? text;
  final GlobalKey<FormState> formStateKey = GlobalKey();

  void pickImage(File image) {
    context.read<ProfileBloc>().add(UploadImageProfileEvent(image));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        EasyLoading.dismiss();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<ProfileBloc>().add(LoadProfileEvent());
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Update Profile',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LoadedProfileState) {
              context.pop();
              EasyLoading.dismiss();
            } else if (state is FailedUpdateProfileState) {
              showSnakbar(state.message);
              EasyLoading.dismiss();
            } else {
              EasyLoading.instance
                ..userInteractions = false
                ..maskType = EasyLoadingMaskType.black;
              EasyLoading.show(status: 'loading...');
            }
          },
          listenWhen:
              (previous, current) =>
                  current is UpdatingProfileState ||
                  current is LoadedProfileState ||
                  current is FailedUpdateProfileState,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formStateKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 80,
                  children: [
                    BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is UploadedImageProfileState) {
                          showSnakbar('Image profile updated successfully');
                        }
                        if (state is FaildUploadImageProfileState) {
                          showSnakbar(state.message);
                        }
                      },
                      listenWhen:
                          (previous, current) =>
                              current is UploadedImageProfileState ||
                              current is FaildUploadImageProfileState,
                      builder: (context, state) {
                        if (state is UploadingImageProfileState) {
                          return CustomImageItemShimmer();
                        } else if (state is UploadedImageProfileState) {
                          return CustomProfileImage(
                            onTap: () async {
                              try {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  pickImage(File(image.path));
                                }
                              } on Exception catch (_) {}
                            },
                            image: state.image,
                          );
                        } else {
                          return CustomProfileImage(
                            onTap: () async {
                              try {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  pickImage(File(image.path));
                                }
                              } on Exception catch (_) {}
                            },
                            image: widget.image,
                          );
                        }
                      },
                      buildWhen:
                          (previous, current) =>
                              current is UploadingImageProfileState ||
                              current is FaildUploadImageProfileState ||
                              current is UploadedImageProfileState,
                    ),
                    AuthTextFormField(
                      hint: 'Enter Your Name',
                      preIcon: Icons.person,
                      onSave: (value) {
                        text = value;
                      },
                      validator: (value) {
                        if (value?.replaceAll(' ', '').isEmpty ?? false) {
                          return 'Field name is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 280),
                    CustomAnimatedButton(
                      text: 'Update',
                      onClick: () {
                        if (formStateKey.currentState?.validate() ?? false) {
                          formStateKey.currentState?.save();
                          context.read<ProfileBloc>().add(
                            UpdateProfileEvent(text!),
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
      ),
    );
  }
}

//* important info
//! this an elert
//? this question
//todo this to do
