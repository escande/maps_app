// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/aa_helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        //
        return state.displayManualMarker ? _ManualMarkerBody() : SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          //
          Positioned(top: 70, left: 20, child: _BtnBack()),
          Center(
            child: Transform.translate(
              offset: Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: Icon(
                  Icons.location_on_rounded,
                  size: 60,
                ),
              ),
            ),
          ),

          //Boto de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                child: Text(
                  'Confirmar destion',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                ),
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: StadiumBorder(),
                onPressed: () async {
                  //
                  final start = locationBloc.state.lastKnownLocation;
                  if (start == null) return;

                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  showLoadingMessage(context);

                  final destination = await searchBloc.getCoorsStartToEnd(start, end);
                  mapBloc.drawRoutePolyline(destination);
                  searchBloc.add(OnDesactivateManualMarker());

                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            //
            final searchBloc = BlocProvider.of<SearchBloc>(context, listen: false);

            searchBloc.add(OnDesactivateManualMarker());
          },
        ),
      ),
    );
  }
}
