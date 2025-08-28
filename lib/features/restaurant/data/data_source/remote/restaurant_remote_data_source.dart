import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';

class RestaurantRemoteDataSource {
  final ApiService apiservice;
  const RestaurantRemoteDataSource(this.apiservice);

  Future<Either<Failure, dynamic>> restaurant(String id) async {
    try {
      final data = await apiservice.get(
        endpoint: '${AppStrings.restaurants}/$id/',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, List>> menu(int id) async {
    try {
      final data = await apiservice.get(
        endpoint: '${AppStrings.restaurants}/$id/menu/',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
