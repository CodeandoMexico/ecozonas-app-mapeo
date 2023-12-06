import 'package:equatable/equatable.dart';

class MySessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MySessionInitial extends MySessionState {}

class Loading extends MySessionState {}

class Success extends MySessionState {}

class Error extends MySessionState {}

class UpdateSuccessful extends MySessionState {}