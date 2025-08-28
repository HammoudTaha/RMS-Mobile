import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';

class RemoteBookingDataSource {
  final ApiService _apiService;
  RemoteBookingDataSource(this._apiService);

  Future<Either<Failure, dynamic>> bookings() async {
    try {
      final data = await _apiService.get(endpoint: AppStrings.reservations);
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
