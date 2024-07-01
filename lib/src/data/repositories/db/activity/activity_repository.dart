import '../../../../domain/models/db/activity_db_model.dart';

abstract class ActivityRepository {
  Future<int> addActivity(ActivityDbModel activity);
  
  Future<int> removeActivity(ActivityDbModel activity);

  Future<List<ActivityDbModel>> getMapatonActivities(int mapatonId);
  
  Future<List<ActivityDbModel>> getActivitiesToSend(int mapatonId);
  
  Future updateSentActivities(int mapatonId);
}