import '../../../data/repositories/db/mapaton_data/mapaton_survey_repository_impl.dart';
import '../../models/db/mapaton_data_db_model.dart';
import '../../models/db/survey_data_db_model.dart';

class MapatonSurveyUseCase {
  final MapatonSurveyRepositoryImpl _repository;

  MapatonSurveyUseCase(this._repository);

  Future<String?> getMapatonListData() async {
    return await _repository.getMapatonListData();
  }

  Future<int> addMapatonListData(MapatonDataDbModel mapaton) async {
    final response = await _repository.addMapatonListData(mapaton);
    return response;
  }

  Future<int> updateMapatonListData(MapatonDataDbModel mapaton) async {
    final response = await _repository.updateMapatonListData(mapaton);
    return response;
  }

  Future<String?> getSurveyListData() async {
    return await _repository.getSurveysListData();
  }

  Future<int> addSurveyListData(SurveyDataDbModel survey) async {
    final response = await _repository.addSurveyListData(survey);
    return response;
  }

  Future<int> updateSurveyListData(SurveyDataDbModel survey) async {
    final response = await _repository.updateSurveyListData(survey);
    return response;
  }
}