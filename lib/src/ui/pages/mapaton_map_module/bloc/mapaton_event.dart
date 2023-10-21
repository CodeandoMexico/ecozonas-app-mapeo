import 'package:equatable/equatable.dart';

import '../../../../domain/models/db/activity_db_model.dart';

class MapatonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLocation extends MapatonEvent {}

class GetMarkers extends MapatonEvent {
  final String uuid;

  GetMarkers(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

class AddMarker extends MapatonEvent {
  final ActivityDbModel activity;

  AddMarker(this.activity);

  @override
  List<Object?> get props => [activity];
}

class ShowCenter extends MapatonEvent {
  final bool showCenter;

  ShowCenter({required this.showCenter});

  @override
  List<Object?> get props => [showCenter];
}