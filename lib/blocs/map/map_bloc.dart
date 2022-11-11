import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/themes/aa_themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //
  GoogleMapController? _mapController;

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
