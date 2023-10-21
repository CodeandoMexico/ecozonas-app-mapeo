import 'package:rxdart/subjects.dart';

import '../../../../domain/models/mapaton_model.dart';

class MapatonListBloc {

  final _mapatonController = BehaviorSubject<MapatonModel>();
  final _searchController = BehaviorSubject<String>();

  Stream<MapatonModel> get mapaton => _mapatonController.stream;
  Stream<String> get search => _searchController.stream;
  
  Function(MapatonModel) get setMapaton => _mapatonController.sink.add;
  Function(String) get setSearch => _searchController.sink.add;

  dispose() {
    _mapatonController.close();
    _searchController.close();
  }
}