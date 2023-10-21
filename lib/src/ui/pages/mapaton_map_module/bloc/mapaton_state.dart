import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapatonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapatonInitial extends MapatonState {}

class GettingLocation extends MapatonState {}

class LocationGetted extends MapatonState {
  final LatLng location;

  LocationGetted({required this.location});
  
  @override
  List<Object?> get props => [location];
}

class ErrorGettingLocation extends MapatonState {}

class GettingMarkers extends MapatonState {}

class ErrorGettingMarkers extends MapatonState {}

class MarkersGetted extends MapatonState {}