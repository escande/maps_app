// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/aa_views.dart';

import '../widgets/aa_widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context, listen: false);
    locationBloc.startFolowingUser();

    //TODO: Retornar un objeto tipo Google Maps
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locState) {
            //
            if (locState.lastKnownLocation == null) {
              return Center(
                child: Text('Espere porfavor'),
              );
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  //
                  BlocBuilder<MapBloc, MapState>(
                    builder: (context, mapSate) => MapView(
                      initialLocation: locState.lastKnownLocation!,
                      polylines: mapSate.polylines,
                      markers: mapSate.markers,
                    ),
                  ),
                  SearchBar(),
                  ManualMarker()
                ],
              ),
            );
            // final CameraPosition _kLake = CameraPosition(
            //     bearing: 192.8334901395799, target: state.lastKnownLocation!, zoom: 15);

            // return GoogleMap(mapType: MapType.hybrid, initialCameraPosition: _kLake);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //
          BtnShowRoute(),
          BtnFollowUser(),
          BtnLocation()
        ],
      ),
    );
  }
}
