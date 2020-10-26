import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpDio {
  Dio dio() {
    final String amuseApi = DotEnv().env['AMUSE_API'];

    final Dio _dio = Dio();

    _dio.options.baseUrl = amuseApi;

    return _dio;
  }
}