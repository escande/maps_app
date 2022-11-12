class SearchResult {
  final bool cancel;
  final bool manual;

  SearchResult({required this.cancel, this.manual = false});

  //TOD: otras propiedades
  //name description, latlng

  @override
  String toString() {
    return 'Cancelar: $cancel, Manual: $manual';
  }
}
