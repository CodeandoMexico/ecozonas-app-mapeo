import '../../../../domain/models/db/mapaton_db_model.dart';

abstract class MapatonRepository {
  Future<int> addMapaton(MapatonDbModel mapaton);

  Future<List<MapatonDbModel>> getMapatons();

  Future<MapatonDbModel?> getMapatonById(int id);

  Future<MapatonDbModel?> getMapatonByUuidAndMapper(String uuid, String mapperId);
}