import 'package:equatable/equatable.dart';

class ManageSessionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSessions extends ManageSessionsEvent {}

class DeleteSession extends ManageSessionsEvent {
  final int dbId;

  DeleteSession(this.dbId);

  @override
  List<Object?> get props => [];
}