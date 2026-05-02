import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../../../auth/data/models/user/user.dart';
import '../data_source/local/profile_local_data_source.dart';
import '../data_source/remote/profile_remote_data_source.dart';

class ProfileRepository {
  final ProfileLocalDataSource _profileLocalDataSource;
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  ProfileRepository(
    this._profileLocalDataSource,
    this._profileRemoteDataSource,
    this._connectionInfo,
  );

  Future<Either<Failure, User>> profile() async {
    if (await _connectionInfo.checkConnection()) {
      try {
        final remoteResponse = await _profileRemoteDataSource.profile();
        return remoteResponse.fold(
          (l) {
            try {
              User user = _profileLocalDataSource.getUser();
              return Right(user);
            } on CachException catch (e) {
              return Left(Failure(message: e.message));
            }
          },
          (r) {
            User user = User.fromJson(r);
            return Right(user);
          },
        );
      } on CachException catch (e) {
        return Left(Failure(message: e.message));
      }
    } else {
      try {
        User user = _profileLocalDataSource.getUser();
        return Right(user);
      } on CachException catch (e) {
        return Left(Failure(message: e.message));
      }
    }
  }

  Future<Either<Failure, User>> updateProfile(String name) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _profileRemoteDataSource.updateProfile(name);
      return remoteResponse.fold((l) => Left(l), (r) {
        User user = User.fromJson(r);
        _profileLocalDataSource.setUser(user);
        return Right(user);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, String>> uploadImage(File image) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _profileRemoteDataSource.uploadImage(image);
      return remoteResponse.fold((l) => Left(l), (r) {
        String image = r['profile_image'];
        User user = _profileLocalDataSource.getUser();
        user = user.copyWith(image: image);
        _profileLocalDataSource.setUser(user);
        return Right(image);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
