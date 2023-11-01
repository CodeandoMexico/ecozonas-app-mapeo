import '../../../data/repositories/db/mapper/mapper_repository_impl.dart';
import '../../models/db/mapper_db_model.dart';

class MapperUseCase {
  final MapperRepositoryImpl _repository;

  MapperUseCase(this._repository);

  Future<List<MapperDbModel>> getMappers() async {
    return _repository.getMappers();
  }

  Future<int> addMapper(MapperDbModel mapper) async {
    return _repository.addMapper(mapper);
  }

  Future<int> updateMapper(MapperDbModel mapper) async {
    return _repository.updateMapper(mapper);
  }

  Future<int> deleteSession(int id) async {
    return _repository.removeMapper(id);
  }
}