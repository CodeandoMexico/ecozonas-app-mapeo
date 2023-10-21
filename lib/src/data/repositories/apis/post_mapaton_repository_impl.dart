import '../../../domain/models/api_response_model.dart';
import '../../../domain/models/mapaton_post_model.dart';
import '../../apis/base_api.dart';
import 'post_mapaton_repository.dart';

class PostMapatonRepositoryImpl implements PostMapatonRepository {
  @override
  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton) async {
    return await BaseApi.post(endpoint: 'enviar-mapeo', body: mapaton.toJson(), noToken: true);
  }
}