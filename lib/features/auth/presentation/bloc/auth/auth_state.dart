part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class InitialUserState extends AuthState {
  const InitialUserState();
  @override
  List<Object> get props => [];
}

class LoadingUserState extends AuthState {
  const LoadingUserState();
  @override
  List<Object> get props => [];
}

class FailedUserState extends AuthState {
  final String message;
  const FailedUserState(this.message);
  @override
  List<Object> get props => [message];
}

class LoggedUserState extends AuthState {
  final User user;
  const LoggedUserState(this.user);
  @override
  List<Object> get props => [user];
}

class VerifiedPhoneUserState extends AuthState {
  final String message;
  const VerifiedPhoneUserState(this.message);
  @override
  List<Object> get props => [message];
}

class ResetedPasswordUserState extends AuthState {
  final String message;
  const ResetedPasswordUserState(this.message);
  @override
  List<Object> get props => [message];
}

class SentVerificationCodeState extends AuthState {
  final String message;
  const SentVerificationCodeState(this.message);
  @override
  List<Object> get props => [message];
}

class LoggedoutUserState extends AuthState {
  const LoggedoutUserState();
  @override
  List<Object> get props => [];
}

class ForgetPasswordUserState extends AuthState {
  final String message;
  const ForgetPasswordUserState(this.message);
  @override
  List<Object> get props => [message];
}
