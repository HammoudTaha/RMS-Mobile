import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

class ApiService {
  final Dio _dio;
  const ApiService(this._dio);

  Future post({required String endpoint, data}) async {
    try {
      final Response response = await _dio.post(endpoint, data: data);
  
      return response.data;
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  Future get({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  Future delete({required String endpoint, required data}) async {
    try {
      final Response response = await _dio.delete(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  Future put({
    required String endpoint,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await _dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      errorHandling(e);
    }
  }

  Future patch({
    required String endpoint,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await _dio.patch(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      errorHandling(e);
    }
  }
}
