import '../../data/repositories/preferences/preferences_repository_impl.dart';
import '../models/mapaton_post_model.dart';

class PreferencesUseCase {
  final PreferencesRepositoryImpl _repository;

  PreferencesUseCase(this._repository);

  Mapper? getMapper() {
    return _repository.getMapper();
  }

  void setMapper(Mapper mapper) {
    _repository.setMapper(mapper);
  }
}