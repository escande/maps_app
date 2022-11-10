// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/ui/custom_snackBar.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            //Bloc
            final userLocation = locationBloc.state.lastKnownLocation;

            if (userLocation == null) {
              final snack = CustomSnackBar(
                message: 'Localización no dispnible',
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
            }

            mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}
