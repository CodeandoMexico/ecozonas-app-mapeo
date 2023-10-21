import 'package:equatable/equatable.dart';

class MapatonListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapatonListInitial extends MapatonListState {}

class GettingMapatonData extends MapatonListState {}

class MapatonDataGetted extends MapatonListState {}

class ErrorGettingMapatonData extends MapatonListState {}