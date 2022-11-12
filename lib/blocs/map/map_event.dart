part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  //
  final GoogleMapController mapController;

  const OnMapInitializedEvent(this.mapController);
}

class OnFollowinUserToggle extends MapEvent {
  //
  final bool seguirUsaurio;

  const OnFollowinUserToggle(this.seguirUsaurio);
}

class OnUpdatePolylinesEvent extends MapEvent {
  //
  final List<LatLng> points;

  const OnUpdatePolylinesEvent(this.points);
}

class OnShowMyRouteToggle extends MapEvent {
  final bool showMyRoute;

  const OnShowMyRouteToggle(this.showMyRoute);
}

class OnDisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;

  const OnDisplayPolylinesEvent({required this.polylines});
}
