import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../../../../domain/models/db/mapper_db_model.dart';
import '../../../../../domain/use_cases/db/mapper_use_case.dart';
import 'bloc.dart';

class LoginTabBloc extends Bloc<LoginTabEvent, LoginTabState> {
  LoginTabBloc() : super(LoginTabInitial()) {
    on<GetSessions>((event, emit) => _mapGetSessionsToState(emit));
  }

  final _hasSessionsController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get hasSessions => _hasSessionsController.stream;
  
  Function(bool) get setHasSessions => _hasSessionsController.sink.add;

  dispose() {
    _hasSessionsController.close();
  }
  
  /*
   * EVENTS TO STATE
   */
  void _mapGetSessionsToState(Emitter<LoginTabState> emit) async {
    final sessions = await _getSessions();
    setHasSessions(sessions.isNotEmpty);
  }

  /*
   * METHODS
   */
  Future<List<MapperDbModel>> _getSessions() {
    final useCase = MapperUseCase(MapperRepositoryImpl());
    return useCase.getMappers();
  }
}