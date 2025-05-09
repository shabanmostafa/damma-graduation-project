import 'dart:convert';

import 'package:dio/dio.dart';
import '../secure/secure_storage_service.dart';
import 'api_consumer.dart';
import 'endpoints.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final SecureStorageService secureStorageService;

  DioConsumer({required this.dio, required this.secureStorageService}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await secureStorageService.getValue(ApiKey.accessToken);
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, String>> _getPublicHeaders() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  void handleDioExceptions(DioException e) {
    // If you don’t have a ServerFailure, just print the error
    print('Dio error: ${e.message}');
    throw e;
  }

  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    try {
      final headers = path.contains(Endpoints.login)
          ? await _getPublicHeaders()
          : await _getHeaders();

      // Prepare data based on isFromData flag
      dynamic requestData;
      if (isFromData) {
        requestData = FormData.fromMap(data); // Use FormData
      } else {
        requestData = jsonEncode(data); // Convert to JSON
      }

      final response = await dio.post(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
