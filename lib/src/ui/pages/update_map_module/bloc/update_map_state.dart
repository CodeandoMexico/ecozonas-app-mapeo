import 'package:equatable/equatable.dart';

class UpdateMapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateMapInitial extends UpdateMapState {}

class GettingMapatons extends UpdateMapState {}

class MapatonsGetted extends UpdateMapState {}

class ErrorGettingMapatons extends UpdateMapState {}

class SendingMapaton extends UpdateMapState {}

class MapatonSent extends UpdateMapState {}

class ErrorSendingMapaton extends UpdateMapState {
  final String error;

  ErrorSendingMapaton(this.error);

  @override
  List<Object?> get props => [error];
}