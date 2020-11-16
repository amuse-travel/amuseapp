import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

import '../enums/api_url_enum.dart';

class HttpDio {
  HttpDio({
    @required this.apiUrlEnum,
  }): assert(apiUrlEnum != null);

  final ApiUrlEnum apiUrlEnum;

  Dio dio() {
    final String amuseApi = DotEnv().env['AMUSE_API'];
    final String chatApi = DotEnv().env['CHAT_API'];

    final Dio _dio = Dio();

    if (apiUrlEnum == ApiUrlEnum.amuse) {
      _dio.options.baseUrl = amuseApi;
    } else {
      _dio.options.baseUrl = chatApi;
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.headers['x-locale'] = 'ko';

    return _dio;
  }
}
