import 'package:equatable/equatable.dart';

class ManageSessionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManageSessionInitial extends ManageSessionsState {}

class GettingSessions extends ManageSessionsState {}

class SessionsGetted extends ManageSessionsState {}

class ErrorGettingSessions extends ManageSessionsState {}