import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class BadCertificateException extends ServerException {
  const BadCertificateException({required super.message});
}

class ConnectTimeOutException extends ServerException {
  const ConnectTimeOutException({required super.message});
}

class SendTimeoutException extends ServerException {
  const SendTimeoutException({required super.message});
}

class ReceiveTimeoutException extends ServerException {
  const ReceiveTimeoutException({required super.message});
}

class BadResponseException extends ServerException {
  const BadResponseException({required super.message});
}

class ConnectionErrorException extends ServerException {
  const ConnectionErrorException({required super.message});
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException({required super.message});
}

class ForbiddenException extends ServerException {
  const ForbiddenException({required super.message});
}

class NotFoundException extends ServerException {
  const NotFoundException({required super.message});
}

class CofficientException extends ServerException {
  CofficientException({required super.message});
}

class CancelException extends ServerException {
  CancelException({required super.message});
}

class UnknownException extends ServerException {
  UnknownException({required super.message});
}

class CachException extends ServerException {
  CachException({required super.message});
}

void errorHandling(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ConnectTimeOutException(
        message: 'Connection timeout. Please try again later',
      );
    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        message: 'Send timeout. Please try again later',
      );
    case DioExceptionType.receiveTimeout:
      throw SendTimeoutException(
        message: 'Recive timeout. Please try again later',
      );
    case DioExceptionType.badCertificate:
      throw SendTimeoutException(
        message: 'Sorry your credentials invalid. Please try again',
      );
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw BadResponseException(
            message:
                e.response!.data['error'] ??
                'Sorry your credentials invalid. Please try again',
          );
        case 401:
          throw UnauthorizedException(
            message:
                e.response!.data['error'] ??
                'Sorry your credentials invalid. Please try again',
          );
        case 403:
          throw ForbiddenException(message: e.response!.data);
        case 404:
          throw NotFoundException(message: 'Sorry not found. Please try again');
        case 500:
          throw NotFoundException(
            message: 'Internal Server Error, Please try again later',
          );
      }
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        message: 'No internet Connection, Please try again',
      );
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      throw UnknownException(message: 'Something went wrong, Please try again');
  }
}
