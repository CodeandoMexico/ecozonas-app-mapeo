import 'package:equatable/equatable.dart';

import '../../../../../domain/models/db/mapper_db_model.dart';

class NewIdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAlias extends NewIdEvent {
  final MapperDbModel mapper;

  AddAlias(this.mapper);

  @override
  List<Object?> get props => [mapper];
}