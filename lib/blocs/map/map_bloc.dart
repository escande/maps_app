import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/helpers/aa_helpers.dart';
import 'package:maps_app/models/route_destination.dart';
import 'package:maps_app/themes/aa_themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //
  GoogleMapController? _mapController;

  LatLng? mapCenter;

  final LocationBloc locationBloc;

  StreamSubscription<LocationState>? locationStreamSuscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    locationStreamSuscription = locationBloc.stream.listen((locationState) {
      //
      if (locationBloc.state.myLocationHistory.isNotEmpty) {
        add(OnUpdatePolylinesEvent(locationBloc.state.myLocationHistory));
      }

      if (!state.estaSiguiendoUsaurio) return;

      if (locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });

    on<OnShowMyRouteToggle>(
      (event, emit) => emit(state.copyWith(mostrarMiRuta: event.showMyRoute)),
    );

    on<OnFollowinUserToggle>(
      (event, emit) => emit(state.copyWith(estaSiguiendoUsaurio: event.seguirUsaurio)),
    );

    on<OnDisplayPolylinesEvent>(
      (event, emit) =>
          emit(state.copyWith(polylines: event.polylines, markers: event.markers)),
    );

    on<OnUpdatePolylinesEvent>(_updatePolylines);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    //
    _mapController = event.mapController;

    //No funciona
    final mapTheme = jsonEncode(nigthMapTheme);
    _mapController?.setMapStyle(mapTheme);

    emit(state.copyWith(esMapaIniciado: true));
  }

  void _updatePolylines(OnUpdatePolylinesEvent event, Emitter<MapState> emit) {
    //
    final myRoute = Polyline(
        polylineId: const PolylineId('MyRoute'),
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        color: Colors.lightGreen,
        width: 8,
        points: event.points);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void drawRoutePolyline(RouteDestination destination) async {
    //
    final myRoute = Polyline(
        polylineId: const PolylineId('MyRoute'),
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        color: Colors.lightGreen,
        width: 8,
        points: destination.points);

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    //Comentamos los iconos para probar el customMarker
    // final startMarkerIcon = await getAssetsImageMarkers();
    // final endMarkerIcon = await getNetworkImageMarker();

    final customStartMarker = await getStartCustomMarker(tripDuration, 'Inicio');
    final customEndMarker =
        await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: customStartMarker,
      anchor: Offset(0.1, 0.9),
      // infoWindow: InfoWindow(
      //   title: 'Inicio',
      //   snippet: 'Kms: $kms, duracion: $tripDuration',
      // )
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: customEndMarker,
      anchor: Offset(0.5, 0.9),
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeNameEs,
      // )
    );

    final currentMarkets = Map<String, Marker>.from(state.markers);
    currentMarkets['start'] = startMarker;
    currentMarkets['end'] = endMarker;

    //Hago una copia ya que no puedo alterar el estado, sino copiarlo
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    add(OnDisplayPolylinesEvent(polylines: currentPolylines, markers: currentMarkets));

    await Future.delayed(const Duration(milliseconds: 300));

    //Comentamos controller para probar el customMarker
    //_mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void moveCamera(LatLng newLocation) {
    //
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  void toggleFollowUser(bool follow) {
    moveCamera(locationBloc.state.lastKnownLocation!);
    add(OnFollowinUserToggle(follow));
  }

  void toggleMostrarRuta(bool showRoute) {
    add(OnShowMyRouteToggle(showRoute));
  }

  @override
  Future<void> close() {
    locationStreamSuscription?.cancel();
    return super.close();
  }
}
