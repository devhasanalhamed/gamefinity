import 'package:gamefinity/core/network/dio_service.dart';

class RestApiService {
  final _dio = DioService().dio;

  Future<dynamic> getData(String path) async {
    final response = await _dio.get(path);
    return response;
  }

  Future<dynamic> postData(String path) async {
    final response = await _dio.post(path);
    return response;
  }
}
