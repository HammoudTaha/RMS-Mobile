import 'package:dio/dio.dart';
import '../../constants/strings.dart';
import '../../errors/exceptions.dart';
import '../local_service/secure_storage.dart';

class ApiIntercepter extends Interceptor {
  final SecureStorage _secureStorage;
  final Dio _dio;
  const ApiIntercepter(this._secureStorage, this._dio);
  @override
  void onRequest(options, handler) async {
    if (isAuhedRoutes(options)) {
      try {
        final String accessToken = await _secureStorage.get(
          key: AppStrings.cashedAccessToken,
        );
        options.headers['Authorization'] = 'Bearer $accessToken';
      } on CachException catch (_) {}
    }
    super.onRequest(options, handler);
  }

  @override
  onError(err, handler) async {
    if (err.response?.statusCode == 401) {
      if (isAuhedRoutes(err.requestOptions)) {
        try {
          final String refreshToken = await _secureStorage.get(
            key: AppStrings.cashedARefreshToken,
          );
          if (await verifyToken(refreshToken)) {
            await this.refreshToken(refreshToken);
            final String accessToken = await _secureStorage.get(
              key: AppStrings.cashedAccessToken,
            );
            err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
            handler.resolve(await _dio.fetch(err.requestOptions));
          } else {}
        } on Exception catch (_) {
          handler.next(err);
        }
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> refreshToken(String refresh) async {
    try {
      final Response response = await _dio.post(
        AppStrings.refreshToken,
        data: {"refresh": refresh},
      );
      _secureStorage.set(
        key: AppStrings.cashedAccessToken,
        value: response.data['access'],
      );
    } on DioException catch (_) {}
  }

  Future<bool> verifyToken(String token) async {
    try {
      await _dio.post(AppStrings.verifyToken, data: {"token": token});
      return true;
    } on DioException catch (_) {
      return false;
    }
  }

  isAuhedRoutes(RequestOptions options) {
    return options.path.contains(AppStrings.logout) ||
        options.path.contains(AppStrings.profile) ||
        options.path.contains(AppStrings.orders) ||
        options.path.contains(AppStrings.reservations) ||
        options.path.contains('reserve');
  }
}
