import 'package:dio/dio.dart';

const accessToken = 'Poner el API aqui';

class TrafficInterceptor extends Interceptor {
  //
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
