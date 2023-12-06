import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../../../../data/repositories/preferences/preferences_repository_impl.dart';
import '../../../../../domain/models/db/mapper_db_model.dart';
import '../../../../../domain/models/mapaton_post_model.dart';
import '../../../../../domain/use_cases/db/mapper_use_case.dart';
import '../../../../../domain/use_cases/preferences_use_case.dart';
import 'bloc.dart';

class NewSessionBloc extends Bloc<NewSessionEvent, NewSessionState> {
  NewSessionBloc() : super(NewSessionInitial()) {
    on<CreateNewSession>((event, emit) => _mapCreateNewSessionToState(emit));
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
  
  /*
   * EVENTS TO STATE
   */
  void _mapCreateNewSessionToState(Emitter<NewSessionState> emit) async {
    emit(CreatingNewSession());
    try {
      final id = await _saveSession();
      emit(NewSessionCreated(id));
    } catch (err) {
      emit(ErrorCreatedNewSession());
    }
  }  

  /*
   * METHODS
   */
  Future<int> _saveSession() async {
    final rand = Random();
    final mapperId = rand.nextInt(10000);

    final mapperUseCase = MapperUseCase(MapperRepositoryImpl());
    int dbId = await mapperUseCase.addMapper(MapperDbModel(
      mapperId: mapperId,
      alias: '',
      gender: _genderController.value,
      age: _ageController.value,
      disability: _disabilityController.value
    ));

    final preferencesUserCase = PreferencesUseCase(PreferencesRepositoryImpl());
    preferencesUserCase.setMapper(Mapper(
      dbId: dbId,
      id: mapperId,
      sociodemographicData: SociodemographicData(
        gender: _genderController.value,
        ageRange: _ageController.value,
        disability: _disabilityController.value
      )
    ));

    return mapperId;
  }
}