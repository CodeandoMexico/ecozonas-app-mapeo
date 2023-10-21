import '../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../models/db/activity_db_model.dart';

class ActivityUseCase {
  final ActivityRepositoryImpl _repository;

  ActivityUseCase(this._repository);

  Future<int> addActivity(ActivityDbModel activity) async {
    final response = await _repository.addActivity(activity);
    return response;
  }

  Future<List<ActivityDbModel>> getMapatonActivities(int mapatonId) async {
    return await _repository.getMapatonActivities(mapatonId);
  }
}