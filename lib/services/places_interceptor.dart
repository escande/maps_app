import 'package:dio/dio.dart';
import 'package:maps_app/services/aa_services.dart';

class PlacesInterceptor extends Interceptor {
  //
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({'limit': 7, 'language': 'es', 'access_token': accessToken});

    super.onRequest(options, handler);
  }
}
