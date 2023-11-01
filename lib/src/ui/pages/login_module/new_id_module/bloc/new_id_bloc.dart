import 'package:ecozonas/src/data/preferences/user_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../../../../domain/models/db/mapper_db_model.dart';
import '../../../../../domain/use_cases/db/mapper_use_case.dart';
import 'bloc.dart';

class NewIdBloc extends Bloc<NewIdEvent, NewIdState> {
  NewIdBloc() : super(NewIdInitial()) {
    on<AddAlias>((event, emit) => _mapAddAliasToState(emit, event.alias));
  }

  final _aliasController = BehaviorSubject<String>();

  Stream<String> get alias => _aliasController.stream;
  
  Function(String) get setAlias => _aliasController.sink.add;

  dispose() {
    _aliasController.close();
  }
  
  /*
   * EVENT TO STATE
   */
  void _mapAddAliasToState(Emitter<NewIdState> emit, String alias) async {
    emit(AddingAlias());
    try {
      await _updateMapper(alias);
      emit(AliasAdded());
    } catch (err) {
      emit(ErrorAddingAlias());
    }
  }

  /*
   * METHODS
   */
  Future<int> _updateMapper(String alias) async {
    final prefs = UserPreferences();
    final useCase = MapperUseCase(MapperRepositoryImpl());

    return await useCase.updateMapper(MapperDbModel(
      id: prefs.getMapper!.dbId,
      mapperId: prefs.getMapper!.id,
      alias: alias,
      gender: prefs.getMapper!.sociodemographicData.genre,
      age: prefs.getMapper!.sociodemographicData.ageRange,
      disability: prefs.getMapper!.sociodemographicData.disability
    ));
  }
}