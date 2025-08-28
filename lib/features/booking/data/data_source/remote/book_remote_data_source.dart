import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/utils/enum.dart';
import '../../../../restaurant/data/models/restaurant/restaurant.dart';
import '../../models/duration/duration.dart';
import '../../models/table/table.dart';
import '../../models/time/time.dart';

class BookRemoteDataSource {
  final ApiService _apiService;
  const BookRemoteDataSource(this._apiService);

  Future<Either<Failure, dynamic>> dates(DateParams params) async {
    try {
      final data = await _apiService.get(
        endpoint:
            '${AppStrings.restaurants}/${params.restaurant.id}/available-dates/?party_size=${params.partySize}',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> times(TimeParams params) async {
    try {
      final data = await _apiService.get(
        endpoint:
            '${AppStrings.restaurants}/${params.restaurant.id}/available-times/?party_size=${params.partySize}&date=${params.date}',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> durations(DurationParams params) async {
    try {
      final data = await _apiService.get(
        endpoint:
            '${AppStrings.restaurants}/${params.restaurant.id}/available-durations/?party_size=${params.partySize}&date=${params.date}&time=${params.time.time}',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> tables(TableParams params) async {
    try {
      final data = await _apiService.get(
        endpoint:
            '${AppStrings.restaurants}/${params.restaurant.id}/available-tables/?party_size=${params.partySize}&date=${params.date}&time=${params.time.time}&duration=${params.duration.duration}',
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> book(BookParams params) async {
    try {
      final data = await _apiService.post(
        endpoint: '${AppStrings.restaurants}/${params.restaurant.id}/reserve/',
        data: {
          'selection_type':
              params.bookType == BookType.customized ? 'customized' : 'smart',
          if (params.bookType == BookType.customized)
            'table_id': params.table!.id,
          'date': params.date,
          'time': params.time.time,
          'party_size': params.partySize,
          'duration_hours': params.duration.duration,
          'special_requests': params.specialRequest,
          if (params.bookType == BookType.random)
            'user_preferences': {
              'quiet_area': params.userPreferences!.quietArea,
              'window_seat': params.userPreferences!.windowSeat,
              'romantic_setting': params.userPreferences!.romanticSetting,
              'near_kitchen': params.userPreferences!.nearKitchen,
              'accessible': params.userPreferences!.accessible,
            },
        },
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

class DateParams {
  final Restaurant restaurant;
  final int partySize;

  const DateParams(this.restaurant, this.partySize);
}

class TimeParams extends DateParams {
  final String date;
  const TimeParams(this.date, super.restaurant, super.partySize);
}

class DurationParams extends TimeParams {
  final TimeItem time;
  const DurationParams(
    this.time,
    super.date,
    super.restaurant,
    super.partySize,
  );
}

class TableParams extends DurationParams {
  final DurationItem duration;
  const TableParams(
    this.duration,
    super.time,
    super.date,
    super.restaurant,
    super.partySize,
  );
}

class BookParams extends TableParams {
  final Table? table;
  final BookType bookType;
  final String specialRequest;
  final UserPreferencesParams? userPreferences;
  const BookParams(
    this.table,
    this.bookType,
    this.specialRequest,
    this.userPreferences,
    super.duration,
    super.time,
    super.date,
    super.restaurant,
    super.partySize,
  );
}

class UserPreferencesParams {
  final bool quietArea;
  final bool windowSeat;
  final bool romanticSetting;
  final bool nearKitchen;
  final bool accessible;
  UserPreferencesParams({
    required this.quietArea,
    required this.windowSeat,
    required this.romanticSetting,
    required this.nearKitchen,
    required this.accessible,
  });
}
