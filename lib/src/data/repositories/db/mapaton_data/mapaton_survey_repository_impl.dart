import '../../../../domain/models/db/mapaton_data_db_model.dart';
import '../../../../domain/models/db/survey_data_db_model.dart';
import '../../../db/my_database.dart';
import 'mapaton_survey_repository.dart';

class MapatonSurveyRepositoryImpl implements MapatonSurveyRepository {
  @override
  Future<String?> getMapatonListData() async {
    final response = await MyDatabase.instance.getAll(mapatonsListTable);
    if (response != null) {
      final list = mapatonDataDbFromJson(response);
      if (list.isNotEmpty) {
        return list[0].data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  
  @override
  Future<int> addMapatonListData(MapatonDataDbModel mapaton) async {
    final response = await MyDatabase.instance.insert(mapatonsListTable, mapaton.toJson());
    return response;
  }

  @override
  Future<int> updateMapatonListData(MapatonDataDbModel mapaton) async {
    final response = await MyDatabase.instance.update(mapatonsListTable, mapaton.id!, mapaton.toJson());
    return response;
  }

  @override
  Future<String?> getSurveysListData() async {
    final response = await MyDatabase.instance.getAll(surveyListTable);
    if (response != null) {
      final list = surveyDataDbFromJson(response);
      if (list.isNotEmpty) {
        return list[0].data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  
  @override
  Future<int> addSurveyListData(SurveyDataDbModel survey) async {
    final response = await MyDatabase.instance.insert(surveyListTable, survey.toJson());
    return response;
  }

  @override
  Future<int> updateSurveyListData(SurveyDataDbModel survey) async {
    final response = await MyDatabase.instance.update(surveyListTable, survey.id!, survey.toJson());
    return response;
  }
}