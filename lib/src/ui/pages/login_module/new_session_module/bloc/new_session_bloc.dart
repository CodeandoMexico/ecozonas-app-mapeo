import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class NewSessionBloc extends Bloc<NewSessionEvent, NewSessionState> {
  NewSessionBloc() : super(NewSessionInitial()) {
    on<NewSessionEvent>((event, emit) { });
  }

  final _genderController = BehaviorSubject<String>();
  final _ageController = BehaviorSubject<String>();
  final _disabilityController = BehaviorSubject<String>();

  Stream<String> get gender => _genderController.stream;
  Stream<String> get age => _ageController.stream;
  Stream<String> get disability => _disabilityController.stream;

  Stream<bool> get isValid => CombineLatestStream.combine3(gender, age, disability, (a, b, c) {
    return a.isNotEmpty && b.isNotEmpty && c.isNotEmpty;
  });
  
  Function(String) get setGender => _genderController.sink.add;
  Function(String) get setAge => _ageController.sink.add;
  Function(String) get setDisability => _disabilityController.sink.add;

  dispose() {
    _genderController.close();
    _ageController.close();
    _disabilityController.close();
  }
}