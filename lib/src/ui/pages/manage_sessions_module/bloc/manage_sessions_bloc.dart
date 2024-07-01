import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../../domain/use_cases/db/mapper_use_case.dart';
import 'bloc.dart';

class ManageSessionsBloc extends Bloc<ManageSessionsEvent, ManageSessionsState> {
  ManageSessionsBloc() : super(ManageSessionInitial()) {
    on<GetSessions>((event, emit) => _mapGetSessionsToState(emit));
    on<DeleteSession>((event, emit) => _mapDeleteSessionToState(emit, event.dbId));
  }

  final _sessionsController = BehaviorSubject<List<MapperDbModel>>();

  Stream<List<MapperDbModel>> get sessions => _sessionsController.stream;
  
  Function(List<MapperDbModel>) get setSessions => _sessionsController.sink.add;

  dispose() {
    _sessionsController.close();
  }

  /*
   * EVENTS TO STATES
   */
  void _mapGetSessionsToState(Emitter<ManageSessionsState> emit) async {
    emit(GettingSessions());
    try {
      final sessions = await _getSessions();
      setSessions(sessions);
      emit(SessionsGetted());
    } catch (err) {
      emit(ErrorGettingSessions());
    }
  }

  void _mapDeleteSessionToState(Emitter<ManageSessionsState> emit, int dbId) async {
    await _deleteSession(dbId);
    final list = _sessionsController.value;
    list.removeWhere((x) => x.id == dbId);
    setSessions(list);
  }

  /*
   * METHODS
   */
  Future<List<MapperDbModel>> _getSessions() async {
    final useCase = MapperUseCase(MapperRepositoryImpl());
    return await useCase.getMappers();
  }

  Future<int> _deleteSession(int dbId) async {
    final useCase = MapperUseCase(MapperRepositoryImpl());
    return await useCase.deleteSession(dbId);
  }
}