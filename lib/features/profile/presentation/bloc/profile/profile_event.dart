part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  const UpdateProfileEvent(this.name);
}

class UploadImageProfileEvent extends ProfileEvent {
  final File image;
  const UploadImageProfileEvent(this.image);
}
