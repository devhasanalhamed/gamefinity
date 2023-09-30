import 'package:dio/dio.dart';

class ApiExceptions {
  List<String> getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return [
          'Bad Response Error'
              'Check api url or parameters are invalid'
        ];
      case DioExceptionType.connectionError:
        return [
          'Connection Error'
              'Check your internet connectivity'
        ];
      case DioExceptionType.connectionTimeout:
        return [
          'Connection Timeout'
              'Check your internet connectivity, It may not stable'
        ];
      case DioExceptionType.cancel:
        return [
          'Request Cancelled'
              'Check api url or parameters are invalid'
        ];

      case DioExceptionType.receiveTimeout:
        return [
          'Receive Timeout'
              'Check your internet connectivity, It may not stable'
        ];

      default:
        return [
          'Unknown Error'
              'Please Contact Support'
        ];
    }
  }
}
