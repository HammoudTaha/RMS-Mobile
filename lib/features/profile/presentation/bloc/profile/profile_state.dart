part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {
  const InitialProfileState();
  @override
  List<Object> get props => [];
}

class LoadingProfileState extends ProfileState {
  const LoadingProfileState();
  @override
  List<Object> get props => [];
}

class FailedProfileState extends ProfileState {
  final String message;
  const FailedProfileState(this.message);
  @override
  List<Object> get props => [message];
}

class LoadedProfileState extends ProfileState {
  final User user;
  const LoadedProfileState(this.user);
  @override
  List<Object> get props => [user];
}

class UpdatingProfileState extends ProfileState {
  const UpdatingProfileState();
  @override
  List<Object> get props => [];
}

class FailedUpdateProfileState extends ProfileState {
  final String message;
  const FailedUpdateProfileState(this.message);
  @override
  List<Object> get props => [message];
}

class UploadingImageProfileState extends ProfileState {
  const UploadingImageProfileState();
  @override
  List<Object> get props => [];
}

class FaildUploadImageProfileState extends ProfileState {
  final String message;
  const FaildUploadImageProfileState(this.message);
  @override
  List<Object> get props => [message];
}

class UploadedImageProfileState extends ProfileState {
  final String image;
  const UploadedImageProfileState(this.image);
  @override
  List<Object> get props => [image];
}
