// Copyright (c) 2021, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/services/aa_services.dart';

import '../../models/aa_models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarker>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));

    on<OnDesactivateManualMarker>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));

    on<OnNewPlacesFoundEvent>(
        (event, emit) => emit(state.copyWith(places: event.places)));

    on<OnSearchHistoryEvent>(
        (event, emit) => emit(state.copyWith(history: event.myHistory)));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final resp = await trafficService.getCourseStartToEnd(start, end);

    final distance = resp.routes[0].distance;
    final duration = resp.routes[0].duration;
    final geometry = resp.routes[0].geometry;

    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points
        .map(
          (e) => LatLng(e[0].toDouble(), e[1].toDouble()),
        )
        .toList();

    return RouteDestination(points: latLngList, distance: distance, duration: duration);
  }

  Future getPlacesByQuery(LatLng proximity, String query) async {
    //
    final response = await trafficService.getResultsByQuery(proximity, query);

    add(OnNewPlacesFoundEvent(places: response));
  }
}
