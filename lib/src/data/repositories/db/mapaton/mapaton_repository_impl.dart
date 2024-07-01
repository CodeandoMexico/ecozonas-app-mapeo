import '../../../../domain/models/db/mapaton_db_model.dart';
import '../../../db/my_database.dart';
import 'mapaton_repository.dart';

class MapatonRepositoryImpl implements MapatonRepository {
  @override
  Future<int> addMapaton(MapatonDbModel mapaton) async {
    final response = await MyDatabase.instance.insert(mapatonsTable, mapaton.toJson());
    return response;
  }
  
  @override
  Future<List<MapatonDbModel>> getMapatons() async {
    final response = await MyDatabase.instance.getAll(mapatonsTable);
    if (response != null) {
      return mapatonDbModelListFromJson(response);
    } else {
      return [];
    }
  }

  @override
  Future<MapatonDbModel?> getMapatonById(int id) async {
    final response = await MyDatabase.instance.getById(mapatonsTable, id);
    if (response != null) {
      final mapaton = MapatonDbModel.fromJson(response);
      return mapaton;
    } else {
      return null;
    }
  }
  
  @override
  Future<MapatonDbModel?> getMapatonByUuidAndMapper(String uuid, String mapperId) async {
    final response = await MyDatabase.instance.getMapatonByUuidAndMapper(mapatonsTable, uuid, mapperId);
    if (response != null) {
      final mapaton = MapatonDbModel.fromJson(response);
      return mapaton;
    } else {
      return null;
    }
  }
}