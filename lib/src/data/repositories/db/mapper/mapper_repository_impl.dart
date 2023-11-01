import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../db/my_database.dart';
import 'mapper_repository.dart';

class MapperRepositoryImpl implements MapperRepository {
  @override
  Future<int> addMapper(MapperDbModel mapper) async {
    final response = await MyDatabase.instance.insert(mappersTable, mapper.toJson());
    return response;
  }

  @override
  Future<List<MapperDbModel>> getMappers() async {
    final response = await MyDatabase.instance.getAll(mappersTable);
    if (response != null) {
      return mapperDbModelListFromJson(response);
    } else {
      return [];
    }
  }
  
  @override
  Future<int> updateMapper(MapperDbModel mapper) async {
    final response = await MyDatabase.instance.update(mappersTable, mapper.id!, mapper.toJson());
    return response;
  }

  @override
  Future<int> removeMapper(int id) async {
    final response = await MyDatabase.instance.delete(mappersTable, id);
    return response;
  }
}