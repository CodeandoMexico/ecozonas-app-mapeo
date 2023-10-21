import '../../../domain/models/mapaton_post_model.dart';

abstract class PreferencesRepository {
  Mapper? getMapper();

  void setMapper(Mapper mapper);
}