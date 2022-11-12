// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        //
        ListTile(
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
        )
      ],
    );
  }
}
