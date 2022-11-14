import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {
  //
  final LatLng initialLocation;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapView(
      {Key? key,
      required this.initialLocation,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    final cameraPosition = CameraPosition(target: initialLocation, zoom: 15);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    //Map<String, Polyline> polylines = Map.from(mapBloc.state.polylines);
    if (!mapBloc.state.mostrarMiRuta) {
      polylines.removeWhere(
        (key, value) => key == 'myRoute',
      );
    }

    //Creamos un sizebox para poder ocupar todo el ancho ya que estamos dentro de un Stack
    return SizedBox(
        //
        width: size.width,
        height: size.height,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: cameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          //TODO: Markers
          markers: markers.values.toSet(),
          //TODO: polylines
          polylines: polylines.values.toSet(),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
          //TODO: otros objetos
        ));
  }
}
