import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/aa_models.dart';
import 'package:maps_app/services/aa_services.dart';

class TrafficService {
  final Dio _dioTraffic;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  TrafficService() : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor());

  Future<TrafficResponse> getCourseStartToEnd(LatLng start, LatLng end) async {
    //
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    // final params = {
    //   'alternatives': true,
    //   'geometries': 'polyline6',
    //   'overview': 'simplified',
    //   'steps': false,
    //   'access_token':
    //       'pk.eyJ1IjoianBhbGVybW82OSIsImEiOiJja3o4amp5MHgwdzN4MnVtdXBpOXY0cnVjIn0.o56TJI4DGM_pIHtNjd1qfg'
    // };

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }
}
