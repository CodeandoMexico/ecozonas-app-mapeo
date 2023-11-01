import 'package:equatable/equatable.dart';

class ContinueSessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContinueSessionInitial extends ContinueSessionState {}

class GettingSessions extends ContinueSessionState {}

class SessionsGetted extends ContinueSessionState {}

class ErrorGettingSessions extends ContinueSessionState {}