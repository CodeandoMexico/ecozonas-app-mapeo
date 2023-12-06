import '../../../../domain/models/db/activity_db_model.dart';
import '../../../db/my_database.dart';
import 'activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  @override
  Future<int> addActivity(ActivityDbModel activity) async {
    final response = await MyDatabase.instance.insert(activitiesTable, activity.toJson());
    return response;
  }

  @override
  Future<int> removeActivity(ActivityDbModel activity) async {
    final response = await MyDatabase.instance.delete(activitiesTable, activity.id!);
    return response;
  }

  @override
  Future<List<ActivityDbModel>> getMapatonActivities(int mapatonId) async {
    final response = await MyDatabase.instance.getMapatonActivities(activitiesTable, mapatonId);
    if (response != null) {
      return activityDbModelListFromJson(response);
    } else {
      return [];
    }
  }

  @override
  Future<List<ActivityDbModel>> getActivitiesToSend(int mapatonId) async {
    final response = await MyDatabase.instance.getMapatonActivitiesToSend(activitiesTable, mapatonId);
    if (response != null) {
      return activityDbModelListFromJson(response);
    } else {
      return [];
    }
  }
  
  @override
  Future updateSentActivities(int mapatonId) async {
    await MyDatabase.instance.updateSentActivities(mapatonId);
  }
}