import 'package:equatable/equatable.dart';

import '../../../../domain/models/db/mapaton_db_model.dart';

class UpdateMapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMapatons extends UpdateMapEvent {}

class GetMapatonById extends UpdateMapEvent {}

class SendMapaton extends UpdateMapEvent {
  final MapatonDbModel mapaton;

  SendMapaton(this.mapaton);

  @override
  List<Object?> get props => [mapaton];
}