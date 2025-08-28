import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';

class ProfileRemoteDataSource {
  final ApiService _apiService;
  const ProfileRemoteDataSource(this._apiService);
  Future<Either<Failure, dynamic>> profile() async {
    try {
      final data = await _apiService.get(endpoint: AppStrings.profile);
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> updateProfile(String name) async {
    try {
      final data = await _apiService.put(
        endpoint: AppStrings.updateProfile,
        data: {'first_name': name, 'last_name': name},
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> uploadImage(File image) async {
    try {
      FormData formData = FormData.fromMap({
        'profile_image ': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });
      final data = await _apiService.post(
        endpoint: AppStrings.uploadImage,
        data: formData,
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
