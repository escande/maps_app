import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/services/aa_services.dart';

class RouteDestination {
  //
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endPlace;

  RouteDestination(
      {required this.points,
      required this.duration,
      required this.distance,
      required this.endPlace});
}
