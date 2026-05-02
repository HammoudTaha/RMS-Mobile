import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/remote/book_remote_data_source.dart';
import '../models/data/date.dart';
import '../models/table/table.dart';
import '../models/time/time.dart';
import '../models/duration/duration.dart';

class BookRepository {
  final BookRemoteDataSource _bookRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  BookRepository(this._bookRemoteDataSource, this._connectionInfo);

  Future<Either<Failure, Date>> dates(DateParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _bookRemoteDataSource.dates(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        try {
          r['party_size'] = params.partySize;
          final Date date = Date.fromJson(r);
          return Right(date);
        } on Exception catch (_) {
          return Left(
            Failure(message: 'Something went wrong, Please try again'),
          );
        }
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, Time>> times(TimeParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _bookRemoteDataSource.times(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        try {
          final Time time = Time.fromJson(r);
          return Right(time);
        } on Exception catch (_) {
          return Left(
            Failure(message: 'Something went wrong, Please try again'),
          );
        }
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, Duration>> durations(DurationParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _bookRemoteDataSource.durations(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        try {
          final Duration duration = Duration.fromJson(r);
          return Right(duration);
        } on Exception catch (_) {
          return Left(
            Failure(message: 'Something went wrong, Please try again'),
          );
        }
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, List<Table>>> tables(TableParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _bookRemoteDataSource.tables(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        List<Table> tables = [];
        try {
          for (var element in r) {
            tables.add(Table.fromJson(element));
          }
        } on Exception catch (_) {
          return Left(
            Failure(message: 'Something went wrong, Please try again'),
          );
        }
        return Right(tables);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> book(BookParams params) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _bookRemoteDataSource.book(params);
      return remoteResponse.fold((l) => Left(l), (r) {
        return Right(r['reservation']);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
