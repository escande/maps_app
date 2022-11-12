import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoianBhbGVybW82OSIsImEiOiJja3o4amp5MHgwdzN4MnVtdXBpOXY0cnVjIn0.o56TJI4DGM_pIHtNjd1qfg';

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
