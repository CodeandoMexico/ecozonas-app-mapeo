import '../../../domain/models/api_response_model.dart';
import '../../../domain/models/mapaton_post_model.dart';
import '../../../domain/models/multipart_file_model.dart';
import '../../apis/base_api.dart';
import 'mapaton_survey_api_repository.dart';

class MapatonSurveyApiRepositoryImpl implements MapatonSurveyApiRepository {
  @override
  Future<ApiResponseModel> getMapatonList() async {
    return await BaseApi.get(endpoint: 'mapaton/?format=json');
  }

  @override
  Future<ApiResponseModel> getSurveyList() async {
    return await BaseApi.get(endpoint: 'survey/?format=json');
  }
  
  @override
  Future<ApiResponseModel> postPhoto(MultipartFileModel file) async {
    return await BaseApi.postMultipart(endpoint: 'upload/', file: file);
  }

  @override
  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton) async {
    return await BaseApi.post(endpoint: 'answer/', body: mapaton.toJson());
  }
}