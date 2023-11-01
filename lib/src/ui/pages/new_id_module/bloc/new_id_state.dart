import 'package:equatable/equatable.dart';

class NewIdState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewIdInitial extends NewIdState {}

class AddingAlias extends NewIdState {}

class AliasAdded extends NewIdState {}

class ErrorAddingAlias extends NewIdState {}