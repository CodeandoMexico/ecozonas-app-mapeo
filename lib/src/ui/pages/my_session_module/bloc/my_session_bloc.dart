import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/use_cases/db/mapper_use_case.dart';
import 'bloc.dart';

class MySessionBloc extends Bloc<MySessionEvent, MySessionState> {
  MySessionBloc() : super(MySessionInitial()) {
    on<GetMapper>((event, emit) => _mapGetMapperToState(emit, event));
    on<UpdateMapper>((event, emit) => _mapUpdateMapperToState(emit, event));
  }

  final _mapperController = BehaviorSubject<MapperDbModel>();

  Stream<MapperDbModel> get mapper => _mapperController.stream;
  
  MapperDbModel get mapperValue => _mapperController.stream.value;
  
  Function(MapperDbModel) get setMapper => _mapperController.sink.add;

  dispose() {
    _mapperController.close();
  }

  /*
   * EVENT TO STATE
   */
  void _mapGetMapperToState(Emitter<MySessionState> emit, GetMapper event) async {
    emit(Loading());
    try {
      final mapper = await _getMapper();
      setMapper(mapper);
      emit(Success());
    } catch (err) {
      emit(Error());
    }
  }

  void _mapUpdateMapperToState(Emitter<MySessionState> emit, UpdateMapper event) async {
    emit(Loading());
    try {
      await _updateMapper(mapperValue);
      setMapper(mapperValue);
      emit(UpdateSuccessful());
    } catch (err) {
      emit(Error());
    }
  }

  /*
   * METHODS
   */
  Future<MapperDbModel> _getMapper() async {
    final mapperId = UserPreferences().getMapper!.dbId;
    final useCase = MapperUseCase(MapperRepositoryImpl());
    final response = await useCase.getMapperById(mapperId!);
    return response!;
  }

  Future<int> _updateMapper(MapperDbModel mapper) async {
    final useCase = MapperUseCase(MapperRepositoryImpl());
    UserPreferences().setMapper = Mapper(
      dbId: mapper.id,
      id: mapper.mapperId,
      sociodemographicData: SociodemographicData(
        gender: mapper.gender,
        ageRange: mapper.age,
        disability: mapper.disability
      )
    );
    return await useCase.updateMapper(mapper);
  }
}