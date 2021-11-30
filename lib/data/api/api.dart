import 'package:dio/dio.dart';

import '../../core/error/exceptions.dart';

abstract class RemoteClient {
  Future get(String uri);
}

class DioClient implements RemoteClient {
  final Dio _dio;

  DioClient({required Dio dio}) : _dio = dio;

  @override
  Future get(String uri) async {
    try {
      final response = await _dio.get(uri);
      return response.data;
    } on DioError catch (e) {
      throw ServerException(message: e.response?.statusMessage);
    }
  }
}
