part of 'map_bloc.dart';

class MapState extends Equatable {
  //
  final bool esMapaIniciado;
  final bool seguirUsuario;

  const MapState({this.esMapaIniciado = false, this.seguirUsuario = false});

  MapState copyWith({bool? esMapaIniciado, bool? seguirUsuario}) => MapState(
      esMapaIniciado: esMapaIniciado ?? this.esMapaIniciado,
      seguirUsuario: seguirUsuario ?? this.seguirUsuario);

  @override
  List<Object> get props => [esMapaIniciado, seguirUsuario];
}

//class MapInitial extends MapState {}
