import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancel;
  final bool manual;
  final LatLng? place;
  final String? name;
  final String? description;

  SearchResult(
      {required this.cancel,
      this.manual = false,
      this.place,
      this.name,
      this.description});

  //TOD: otras propiedades
  //name description, latlng

  @override
  String toString() {
    return 'Cancelar: $cancel, Manual: $manual';
  }
}
