// import 'package:dio/dio.dart';
// import 'api_consumer.dart';
// import 'endpoints.dart';
// import '../errors/failure.dart';

// class DioConsumer extends ApiConsumer {
//   final Dio dio;
//   DioConsumer({required this.dio}) {
//     dio.options.baseUrl = Endpoints.baseUrl;
//     dio.interceptors.add(LogInterceptor(
//       request: true,
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//       responseBody: true,
//       error: true,
//     ));
//   }

//   void handleDioExceptions(DioException e) {
//     throw ServerFailure.fromDioExceptio(e);
//   }

//   @override
//   Future delete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     try {
//       final response = await dio.delete(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }

//   @override
//   Future get(String path,
//       {Object? data, Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await dio.get(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }

//   @override
//   Future patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     try {
//       final response = await dio.patch(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }

//   @override
//   Future post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     try {
//       final response = await dio.post(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//           'Authorization': 'Bearer ${await secureStorageService.getValue(ApiKey.token)}',
//           'Content-Type': 'application/json',
//         }
//         )
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'endpoints.dart';
import '../errors/failure.dart';
import '../secure/secure_storage_service.dart'; // Assuming secure storage is part of your core services

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
    final token = await secureStorageService.getValue(ApiKey.token);
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  void handleDioExceptions(DioException e) {
    throw ServerFailure.fromDioExceptio(e);
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
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
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
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
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.post(
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
}
