part of 'map_bloc.dart';

class MapState extends Equatable {
  //
  final bool esMapaIniciado;
  final bool estaSiguiendoUsaurio;
  final bool mostrarMiRuta;
  final Map<String, Polyline> polylines;
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
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {}; //Forma de inicializar un valor

  MapState copyWith(
          {bool? esMapaIniciado,
          bool? estaSiguiendoUsaurio,
          bool? mostrarMiRuta,
          Map<String, Polyline>? polylines}) =>
      MapState(
          esMapaIniciado: esMapaIniciado ?? this.esMapaIniciado,
          estaSiguiendoUsaurio: estaSiguiendoUsaurio ?? this.estaSiguiendoUsaurio,
          mostrarMiRuta: mostrarMiRuta ?? this.mostrarMiRuta,
          polylines: polylines ?? this.polylines);

  @override
  List<Object> get props =>
      [esMapaIniciado, estaSiguiendoUsaurio, mostrarMiRuta, polylines];
}

//class MapInitial extends MapState {}
