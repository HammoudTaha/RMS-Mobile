part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class LoginUserEvent extends AuthEvent {
  final LoginParams loginParams;
  const LoginUserEvent({required this.loginParams});
}

class RegisterUserEvent extends AuthEvent {
  final RegisterParams registerParams;
  const RegisterUserEvent({required this.registerParams});
}

class SendVerificationCodeUserEvent extends AuthEvent {
  final String phone;
  const SendVerificationCodeUserEvent(this.phone);
}

class LogoutUserEvent extends AuthEvent {
  const LogoutUserEvent();
}

class VerifyPhoneUserEvent extends AuthEvent {
  final VerifyPhoneParams verifyPhoneParams;
  const VerifyPhoneUserEvent(this.verifyPhoneParams);
}

class ResetPasswordUserEvent extends AuthEvent {
  final ResetPasswordParams resetPasswordParams;
  const ResetPasswordUserEvent(this.resetPasswordParams);
}

class ForgetPasswordUserEvent extends AuthEvent {
  final String phone;
  const ForgetPasswordUserEvent(this.phone);
}

class VerifyResetCodeEvent extends AuthEvent {
  final VerifyPhoneParams verifyPhoneParams;
  const VerifyResetCodeEvent(this.verifyPhoneParams);
}
