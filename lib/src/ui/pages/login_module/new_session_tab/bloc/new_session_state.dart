import 'package:equatable/equatable.dart';

class NewSessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewSessionInitial extends NewSessionState {}

class CreatingNewSession extends NewSessionState {}

class NewSessionCreated extends NewSessionState {
  final int id;

  NewSessionCreated(this.id);

  @override
  List<Object?> get props => [id];
}

class ErrorCreatedNewSession extends NewSessionState {}