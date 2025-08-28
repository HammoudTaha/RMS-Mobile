import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/local/user_local_data_source.dart';
import '../data_source/remote/user_remote_data_source.dart';
import '../models/user/user.dart';

class AuthRepository {
  final UserLocalDataSource _userLocalDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  AuthRepository(
    this._userLocalDataSource,
    this._userRemoteDataSource,
    this._connectionInfo,
  );

  Future<Either<Failure, User>> login(LoginParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.login(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        User user = User.fromJson(r['user']);
        _userLocalDataSource.setUser(user);
        _userLocalDataSource.setAccessToken(r['access']);
        _userLocalDataSource.setRefreshToken(r['refresh']);
        _userLocalDataSource.setIsLogedInUser(true);
        return Right(user);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, User>> register(RegisterParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.register(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        User user = User.fromJson(r['user']);
        _userLocalDataSource.setUser(user);
        _userLocalDataSource.setAccessToken(r['access']);
        _userLocalDataSource.setRefreshToken(r['refresh']);
        _userLocalDataSource.setIsLogedInUser(true);
        return Right(user);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> sendVerificationCode(String phone) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.sendVerificationCode(
        phone,
      );
      return remoteResponse.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> forgetPassword(String phone) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.forgetpassword(phone);
      return remoteResponse.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.verifyPhone(params);
      return remoteResponse.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> verifyResetCode(
    VerifyPhoneParams params,
  ) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.verifyResetCode(
        params,
      );
      return remoteResponse.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> resetPassword(
    ResetPasswordParams params,
  ) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _userRemoteDataSource.resetPassword(params);
      return remoteResponse.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, NoParams>> logout() async {
    if (await _connectionInfo.checkConnection()) {
      try {
        final remoteResponse = await _userRemoteDataSource.logout();
        return remoteResponse.fold((l) => Left(l), (r) {
          _userLocalDataSource.clearCash();
          _userLocalDataSource.setIsLogedInUser(false);
          return Right(r);
        });
      } on CachException catch (e) {
        return Left(Failure(message: e.message));
      }
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
