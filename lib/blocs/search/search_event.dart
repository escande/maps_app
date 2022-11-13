part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarker extends SearchEvent {}

class OnDesactivateManualMarker extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<Feature> places;

  const OnNewPlacesFoundEvent({required this.places});
}

class OnSearchHistoryEvent extends SearchEvent {
  final List<Feature> myHistory;

  const OnSearchHistoryEvent({required this.myHistory});
}
