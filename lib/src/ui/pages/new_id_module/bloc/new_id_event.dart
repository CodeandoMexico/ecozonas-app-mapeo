import 'package:equatable/equatable.dart';

class NewIdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAlias extends NewIdEvent {
  final String alias;

  AddAlias(this.alias);

  @override
  List<Object?> get props => [alias];
}