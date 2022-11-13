// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/aa_models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  //Para modificar algun aspecto del SearchDelegate se realiza desde el constructor
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      //Text('Build acctions')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, SearchResult(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final myProximity = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation;
    searchBloc.getPlacesByQuery(myProximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        //
        final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (context, index) {
            //
            final place = places[index];

            return ListTile(
              //
              title: Text(place.text),
              subtitle: Text(place.placeNameEs),
              leading: Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResult(
                    cancel: false,
                    manual: false,
                    place: LatLng(place.center[1], place.center[0]),
                    name: place.text,
                    description: place.placeNameEs);

                final copyHistory = state.history.toList();

                copyHistory.insert(0, place);

                searchBloc.add(OnSearchHistoryEvent(myHistory: copyHistory));

                close(context, result);
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //
    final historico = BlocProvider.of<SearchBloc>(context).state.history;
    final listado = historico
        .map<ListTile>(
          (element) => ListTile(
            title: Text(element.text),
            subtitle: Text(element.placeNameEs),
            leading: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onTap: () {
              //
              final result = SearchResult(
                  cancel: false,
                  manual: false,
                  place: LatLng(element.center[1], element.center[0]),
                  name: element.text,
                  description: element.placeNameEs);

              close(context, result);
            },
          ),
        )
        .toList();

    final manual = ListTile(
      leading: Icon(
        Icons.location_on_outlined,
        color: Colors.black,
      ),
      title: Text(
        'Colocar la ubicacion manualmente',
        style: TextStyle(color: Colors.black),
      ),
      onTap: () {
        //
        final result = SearchResult(cancel: false, manual: true);
        close(context, result);
      },
    );

    listado.insert(0, manual);

    return ListView.separated(
      itemCount: listado.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => listado[index],
    );
  }
}
