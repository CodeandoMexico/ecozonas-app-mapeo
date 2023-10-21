import '../../../domain/models/api_response_model.dart';
import '../../../domain/models/mapaton_post_model.dart';

abstract class PostMapatonRepository {
  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton);
}