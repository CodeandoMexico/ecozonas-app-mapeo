import 'package:equatable/equatable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../../../domain/models/db/activity_db_model.dart';

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

class MarkersGetted extends MapatonState {
  final List<ActivityDbModel> activities;

  MarkersGetted({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class DownloadingRegion extends MapatonState {}

class ErrorDownloadingRegion extends MapatonState {}

class RegionDownloaded extends MapatonState {}

class MarkerAdded extends MapatonState {
  final ActivityDbModel activity;

  MarkerAdded({required this.activity});
  
  @override
  List<Object?> get props => [activity];
}