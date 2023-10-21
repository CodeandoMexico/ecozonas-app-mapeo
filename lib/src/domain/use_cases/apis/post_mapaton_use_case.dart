import '../../../data/repositories/apis/post_mapaton_repository_impl.dart';
import '../../models/api_response_model.dart';
import '../../models/mapaton_post_model.dart';

class PostMapatonUseCase {
  final PostMapatonRepositoryImpl _repository;

  PostMapatonUseCase(this._repository);

  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton) async {
    return await _repository.sendMapaton(mapaton);
  }
}