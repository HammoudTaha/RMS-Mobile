import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';

class HomeRemoteDataSource {
  final ApiService apiservice;
  const HomeRemoteDataSource(this.apiservice);
  Future<Either<Failure, List>> categories() async {
    try {
      final data = await apiservice.get(endpoint: AppStrings.categories);
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, List>> restaurants(String categoryId) async {
    try {
      final data = await apiservice.get(
        endpoint: AppStrings.restaurants,
        queryParameters: {'category_id': categoryId},
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, List>> restaurantsByName(String name) async {
    try {
      final data = await apiservice.get(
        endpoint: AppStrings.restaurants,
        queryParameters: {'search': name},
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
