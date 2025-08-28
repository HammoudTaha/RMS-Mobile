import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../../auth/data/models/user/user.dart';
import '../../../data/repositories/profile_repository.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitialProfileState()) {
    on<LoadProfileEvent>(_onLoadProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<UploadImageProfileEvent>(_onUploadImageProfileEvent);
  }

  void _onLoadProfileEvent(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(LoadingProfileState());
    final result = await (await getIt<Future<ProfileRepository>>()).profile();

    result.fold(
      (fail) => emit(FailedProfileState(fail.message)),
      (user) => emit(LoadedProfileState(user)),
    );
  }

  void _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(UpdatingProfileState());
    final result = await (await getIt<Future<ProfileRepository>>())
        .updateProfile(event.name);

    result.fold(
      (fail) => emit(FailedUpdateProfileState(fail.message)),
      (user) => emit(LoadedProfileState(user)),
    );
  }

  void _onUploadImageProfileEvent(
    UploadImageProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(UploadingImageProfileState());
    final result = await (await getIt<Future<ProfileRepository>>()).uploadImage(
      event.image,
    );

    result.fold(
      (fail) => emit(FaildUploadImageProfileState(fail.message)),
      (image) => emit(UploadedImageProfileState(image)),
    );
  }
}
