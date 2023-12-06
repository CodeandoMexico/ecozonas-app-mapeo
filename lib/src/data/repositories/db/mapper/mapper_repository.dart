import '../../../../domain/models/db/mapper_db_model.dart';

abstract class MapperRepository {
  Future<List<MapperDbModel>> getMappers();
  
  Future<MapperDbModel?> getMapperById(int id);

  Future<int> addMapper(MapperDbModel mapper);

  Future<int> updateMapper(MapperDbModel mapper);

  Future<int> removeMapper(int id);
}