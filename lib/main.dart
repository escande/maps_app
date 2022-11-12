// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/aa_screens.dart';
import 'package:maps_app/services/aa_services.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      // La carga de los blocs es secuecial
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
      BlocProvider(
        create: (context) => LocationBloc(),
      ),
      BlocProvider(
        create: (context) => //Aqui el context ya tiene la información del BlocLocation
            MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),
      ),
      BlocProvider(
        create: (context) => SearchBloc(trafficService: TrafficService()),
      ),
    ],
    child: MapsApp(),
  ));
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //
        debugShowCheckedModeBanner: false,
        title: 'Maps App',
        home: LoadingScreen());
  }
}
