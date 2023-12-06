import '../../../../domain/models/db/mapaton_data_db_model.dart';
import '../../../../domain/models/db/survey_data_db_model.dart';

abstract class MapatonSurveyRepository {
  Future<String?> getMapatonListData();

  Future<int?> addMapatonListData(MapatonDataDbModel mapaton);

  Future<int?> updateMapatonListData(MapatonDataDbModel mapaton);

  Future<String?> getSurveysListData();

  Future<int?> addSurveyListData(SurveyDataDbModel survey);

  Future<int?> updateSurveyListData(SurveyDataDbModel survey);
}