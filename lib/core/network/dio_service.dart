import 'package:dio/dio.dart';
import 'package:gamefinity/core/network/api_constants.dart';

class DioService {
  // options and dio variable defined in constructor

  DioService() {
    final options = BaseOptions(
      baseUrl: ApiConstants.base,
      queryParameters: {
        'key': ApiConstants.apiKey,
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
  }

  late Dio _dio;

  Dio get dio => _dio;
}
