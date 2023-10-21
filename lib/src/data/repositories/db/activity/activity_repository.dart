import '../../../../domain/models/db/activity_db_model.dart';

abstract class ActivityRepository {
  Future<int> addActivity(ActivityDbModel activity);

  Future<List<ActivityDbModel>> getMapatonActivities(int mapatonId);
}