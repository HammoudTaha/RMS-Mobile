import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/user_remote_data_source.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialUserState()) {
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyPhoneUserEvent>(_onVerifyPhoneUser);
    on<ForgetPasswordUserEvent>(_onForgetPassword);
    on<ResetPasswordUserEvent>(_onResetPasswordUser);
    on<VerifyResetCodeEvent>(_onVerifyResetCodeUser);
    on<SendVerificationCodeUserEvent>(_onSendVerifictionCodeUser);
  }

  void _onLoginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingUserState());

    final result = await (await getIt<Future<AuthRepository>>()).login(
      event.loginParams,
    );
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (user) {
        emit(LoggedUserState(user));
      },
    );
  }

  void _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>()).register(
      event.registerParams,
    );
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (user) {
        emit(LoggedUserState(user));
      },
    );
  }

  void _onVerifyPhoneUser(
    VerifyPhoneUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>()).verifyPhone(
      event.verifyPhoneParams,
    );
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (message) {
        emit(VerifiedPhoneUserState(message));
      },
    );
  }

  void _onVerifyResetCodeUser(
    VerifyResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>())
        .verifyResetCode(event.verifyPhoneParams);
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (message) {
        emit(VerifiedPhoneUserState(message));
      },
    );
  }

  void _onResetPasswordUser(
    ResetPasswordUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>()).resetPassword(
      event.resetPasswordParams,
    );

    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (message) {
        emit(ResetedPasswordUserState(message));
      },
    );
  }

  void _onLogoutUser(LogoutUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>()).logout();
    result.fold(
      (fail) => emit(FailedUserState(fail.message)),
      (user) => emit(LoggedoutUserState()),
    );
  }

  void _onSendVerifictionCodeUser(
    SendVerificationCodeUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>())
        .sendVerificationCode(event.phone);
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (message) {
        emit(SentVerificationCodeState(message));
      },
    );
  }

  void _onForgetPassword(
    ForgetPasswordUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await (await getIt<Future<AuthRepository>>()).forgetPassword(
      event.phone,
    );
    result.fold(
      (failed) {
        emit(FailedUserState(failed.message));
      },
      (message) {
        emit(ForgetPasswordUserState(message));
      },
    );
  }
}
