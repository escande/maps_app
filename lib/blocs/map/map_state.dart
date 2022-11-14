part of 'map_bloc.dart';

class MapState extends Equatable {
  //
  final bool esMapaIniciado;
  final bool estaSiguiendoUsaurio;
  final bool mostrarMiRuta;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  /*
    'MiRuta': {
      id: polyline.id,
      points: [[lat, lng], [131,46654], [7897,13213]],
      width: 3,
      color: black87
    }
  */
  const MapState(
      {this.esMapaIniciado = false,
      this.estaSiguiendoUsaurio = true,
      this.mostrarMiRuta = true,
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers})
      : polylines = polylines ?? const {},
        markers = markers ?? const {}; //Forma de inicializar un valor

  MapState copyWith(
          {bool? esMapaIniciado,
          bool? estaSiguiendoUsaurio,
          bool? mostrarMiRuta,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers}) =>
      MapState(
          esMapaIniciado: esMapaIniciado ?? this.esMapaIniciado,
          estaSiguiendoUsaurio: estaSiguiendoUsaurio ?? this.estaSiguiendoUsaurio,
          mostrarMiRuta: mostrarMiRuta ?? this.mostrarMiRuta,
          polylines: polylines ?? this.polylines,
          markers: markers ?? this.markers);

  @override
  List<Object> get props =>
      [esMapaIniciado, estaSiguiendoUsaurio, mostrarMiRuta, polylines, markers];
}

//class MapInitial extends MapState {}
