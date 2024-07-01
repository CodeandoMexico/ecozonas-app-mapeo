import '../../../data/repositories/apis/mapaton_survey_api_repository_impl.dart';
import '../../models/api_response_model.dart';
import '../../models/mapaton_post_model.dart';
import '../../models/multipart_file_model.dart';

class MapatonSurveyApiUseCase {
  final MapatonSurveyApiRepositoryImpl _repository;

  MapatonSurveyApiUseCase(this._repository);

  Future<ApiResponseModel> getMapatonList() async {
    return await _repository.getMapatonList();
  }

  Future<ApiResponseModel> getSurveyList() async {
    return await _repository.getSurveyList();
  }

  Future<ApiResponseModel> postPhoto(MultipartFileModel file) async {
    return await _repository.postPhoto(file);
  }

  Future<ApiResponseModel> sendMapaton(MapatonPostModel mapaton) async {
    return await _repository.sendMapaton(mapaton);
  }
}