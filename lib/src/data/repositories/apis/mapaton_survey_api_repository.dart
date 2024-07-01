import '../../../domain/models/api_response_model.dart';
import '../../../domain/models/mapaton_post_model.dart';
import '../../../domain/models/multipart_file_model.dart';

abstract class MapatonSurveyApiRepository {
  Future<ApiResponseModel> getMapatonList();

  Future<ApiResponseModel> getSurveyList();

  Future<ApiResponseModel> postPhoto(MultipartFileModel file);

  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton);
}