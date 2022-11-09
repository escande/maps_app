// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //
        appBar: AppBar(
          title: Text('Check GPS'),
        ),
        body: Center(child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            print(state);
            return !state.isGpsEnabled ? _EnableGpsMessage() : _AccessButton();
          },
        )));
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Debe de habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //
        Text('Es necesario activar el GPS'),
        MaterialButton(
          child: Text('Solicitar Acceso'),
          color: Colors.black,
          textColor: Colors.white,
          splashColor: Colors.transparent,
          elevation: 0,
          shape: StadiumBorder(),
          onPressed: (() {
            //
            //final blocGps = BlocProvider.of<GpsBloc>(context, listen: false);
            final blocGps = context.read<GpsBloc>(); //Otra alternativa
            blocGps.askGpsAccess();
          }),
        )
      ],
    );
  }
}
