import '../../../domain/models/mapaton_post_model.dart';
import '../../preferences/user_preferences.dart';
import 'preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final _prefs = UserPreferences();

  @override
  Mapper? getMapper() {
    return _prefs.getMapper;
  }

  @override
  void setMapper(Mapper mapper) {
    _prefs.setMapper = mapper;
  }
}