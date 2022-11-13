// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';
import 'package:maps_app/blocs/search/search_bloc.dart';
import 'package:maps_app/delegates/aa_delegates.dart';
import 'package:maps_app/models/aa_models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        //
        return state.displayManualMarker
            ? SizedBox()
            : BounceInDown(child: _SearchBarBody());
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  Future onSearchResults(SearchResult result, BuildContext context) async {
    //
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual) {
      searchBloc.add(OnActivateManualMarker());
      return;
    }

    if (result.place != null) {
      final currentLocation = locBloc.state.lastKnownLocation;
      final routeDestination =
          await searchBloc.getCoorsStartToEnd(currentLocation!, result.place!);

      mapBloc.drawRoutePolyline(routeDestination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        //color: Colors.red,
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            //
            final result =
                await showSearch(context: context, delegate: SearchDestinationDelegate());

            if (result == null) return;

            onSearchResults(result, context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Text(
              '¿A donde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  //
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
