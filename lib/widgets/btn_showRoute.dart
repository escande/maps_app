// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class BtnShowRoute extends StatelessWidget {
  const BtnShowRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            //
            return IconButton(
              icon: Icon(
                state.mostrarMiRuta ? Icons.cancel_rounded : Icons.route_sharp,
                color: Colors.black87,
              ),
              onPressed: () {
                //Bloc

                state.mostrarMiRuta
                    ? mapBloc.toggleMostrarRuta(false)
                    : mapBloc.toggleMostrarRuta(true);
              },
            );
          },
        ),
      ),
    );
  }
}
