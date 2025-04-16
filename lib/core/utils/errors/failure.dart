import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioExceptio(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api sever');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with api sever');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Received timeout with api sever');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request to api sever was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');

      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected error, please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else if (statusCode == 422) {
      String errorDetails = '';
      if (response['data'] is Map) {
        (response['data'] as Map).forEach((key, value) {
          if (value is List) {
            errorDetails += '${value.join(', ')}\n';
          }
        });
      }
      return ServerFailure(errorDetails);
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
