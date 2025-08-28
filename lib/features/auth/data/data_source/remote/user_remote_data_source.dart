import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';
import 'package:dartz/dartz.dart';

class UserRemoteDataSource {
  final ApiService _apiService;
  const UserRemoteDataSource(this._apiService);

  Future<Either<Failure, dynamic>> login(LoginParams params) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.login,
        data: {'phone': params.phone, 'password': params.passwrod},
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> register(RegisterParams params) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.register,
        data: {
          'first_name': params.name,
          'last_name': params.name,
          'phone': params.phone,
          'password': params.password,
          'confirm_password': params.password,
        },
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.verfiyPhone,
        data: {'phone': params.phone, 'code': params.code},
      );
      return Right(data['success']);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, String>> sendVerificationCode(String phone) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.sendVerificationCode,
        data: {'phone': phone},
      );
      return Right(data['success']);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, String>> forgetpassword(String phone) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.forgetPassword,
        data: {'phone': phone},
      );
      return Right(data['success']);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, String>> verifyResetCode(
    VerifyPhoneParams params,
  ) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.verifyResetCode,
        data: {'phone': params.phone, 'code': params.code},
      );
      return Right(data['success']);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, String>> resetPassword(
    ResetPasswordParams params,
  ) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.resetPassword,
        data: {
          'phone': params.phone,
          'code': params.code,
          'new_password': params.newPassword,
          'confirm_password': params.newPassword,
        },
      );
      return Right(data['success']);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, NoParams>> logout() async {
    try {
      await _apiService.post(endpoint: AppStrings.logout);
      return Right(NoParams());
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

class LoginParams {
  final String phone;
  final String passwrod;
  const LoginParams({required this.phone, required this.passwrod});
}

class VerifyPhoneParams {
  final String phone;
  final String code;
  const VerifyPhoneParams({required this.phone, required this.code});
}

class ResetPasswordParams {
  final String phone;
  final String code;
  final String newPassword;
  const ResetPasswordParams({
    required this.code,
    required this.phone,
    required this.newPassword,
  });
}

class RegisterParams {
  final String name;
  final String phone;
  final String password;

  const RegisterParams({
    required this.name,
    required this.phone,
    required this.password,
  });
}

class NoParams {
  const NoParams();
}
