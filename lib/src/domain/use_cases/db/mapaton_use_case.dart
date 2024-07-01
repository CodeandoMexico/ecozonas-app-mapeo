import '../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../models/db/mapaton_db_model.dart';

class MapatonUseCase {
  final MapatonRepositoryImpl _repository;

  MapatonUseCase(this._repository);

  Future<int> addMapaton(MapatonDbModel mapaton) async {
    final response = await _repository.addMapaton(mapaton);
    return response;
  }

  Future<List<MapatonDbModel>> getMapatons() async {
    return await _repository.getMapatons();
  }

  Future<MapatonDbModel?> getMapatonById(int id) async {
    return await _repository.getMapatonById(id);
  }

  Future<MapatonDbModel?> getMapatonsByUuidAndMapper(String uuid, String mapperId) async {
    return await _repository.getMapatonByUuidAndMapper(uuid, mapperId);
  }
}