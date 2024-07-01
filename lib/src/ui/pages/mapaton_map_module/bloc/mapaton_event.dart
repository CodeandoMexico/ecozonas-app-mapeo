import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../../../domain/models/current_activity_model.dart';
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

class RemoveMarker extends MapatonEvent {
  final ActivityDbModel activity;

  RemoveMarker(this.activity);

  @override
  List<Object?> get props => [activity];
}

class ShowCenter extends MapatonEvent {
  final bool showCenter;

  ShowCenter({required this.showCenter});

  @override
  List<Object?> get props => [showCenter];
}

class ShowDownload extends MapatonEvent {
  final bool show;

  ShowDownload({required this.show});

  @override
  List<Object?> get props => [show];
}

class DownloadRegion extends MapatonEvent {
  final String name;
  final LatLngBounds bounds;

  DownloadRegion({required this.name, required this.bounds});

  @override
  List<Object?> get props => [name, bounds];
}

class SetCurrentActivity extends MapatonEvent {
  final CurrentActivityModel? activity;

  SetCurrentActivity({this.activity});

  @override
  List<Object?> get props => [activity];
}