import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../../data/repositories/location/location_repository_impl.dart';
import '../../../../domain/models/db/activity_db_model.dart';
import '../../../../domain/use_cases/db/activity_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../../../domain/use_cases/location_use_case.dart';
import 'bloc.dart';

class MapatonBloc extends Bloc<MapatonEvent, MapatonState> {
  MapatonBloc() : super(MapatonInitial()) {
    on<GetLocation>((event, emit) => _mapGetLocationToState(emit));
    on<GetMarkers>((event, emit) => _mapGetMarkersToState(emit, event.uuid));
    on<AddMarker>((event, emit) => _mapAddMarkerToState(emit, event.activity));
    on<ShowCenter>((event, emit) => _mapShowCenterToState(emit, event.showCenter));
  }

  final _cameraPositionController = BehaviorSubject<LatLng>();
  final _activitiesController = BehaviorSubject<List<ActivityDbModel>>.seeded([]);
  final _showCenterController = BehaviorSubject<bool>.seeded(true);

  Stream<LatLng> get cameraPosition => _cameraPositionController.stream;
  Stream<List<ActivityDbModel>> get activities => _activitiesController.stream;
  Stream<bool> get showCenter => _showCenterController.stream;

  List<ActivityDbModel> get activitiesValue => _activitiesController.stream.value;
  
  Function(LatLng) get setCameraPosition => _cameraPositionController.sink.add;
  Function(List<ActivityDbModel>) get setActivities => _activitiesController.sink.add;
  Function(bool) get setShowCenter => _showCenterController.sink.add;

  dispose() {
    _cameraPositionController.close();
    _activitiesController.close();
    _showCenterController.close();
  }

  /*
   * MAP EVENT TO STATE
   */
  void _mapGetLocationToState(Emitter<MapatonState> emit) async {
    emit(GettingLocation());
    try {
      final location = await _getLocation();
      if (location != null) {
        setCameraPosition(location);
        emit(LocationGetted(location: location));
      } else {
        emit(ErrorGettingLocation());  
      }
    } catch (err) {
      emit(ErrorGettingLocation());
    }
  }

  void _mapGetMarkersToState(Emitter<MapatonState> emit, String uuid) async {
    emit(GettingMarkers());
    try {
      final markers = await _getMarkers(uuid);
      setActivities(markers);
      emit(MarkersGetted());
    } catch (err) {
      emit(ErrorGettingMarkers());
    }
  }

  void _mapAddMarkerToState(Emitter<MapatonState> emit, ActivityDbModel activity) async {
    final list = activitiesValue.toList();
    list.add(activity);
    setActivities(list);
  }

  void _mapShowCenterToState(Emitter<MapatonState> emit, bool showCenter) async {
    setShowCenter(showCenter);
  }

  /*
   * METHODS
   */
  Future<LatLng?> _getLocation() async {
    final useCase = LocationUseCase(LocationRepositoryImpl());
    final locationPermission = await useCase.checkLocationPermission();

    if (locationPermission) {
      final data = await useCase.getLocation();
      return LatLng(data.latitude!, data.longitude!);
    } else {
      return null;
    }
  }

  Future<List<ActivityDbModel>> _getMarkers(String uuid) async {
    final prefs = UserPreferences();
    final useCase = MapatonUseCase(MapatonRepositoryImpl());
    final mapaton = await useCase.getMapatonsByUuidAndMapper(uuid, prefs.getMapper!.id.toString());

    if (mapaton != null) {
      final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
      return await activityUseCase.getMapatonActivities(mapaton.id!);
    } else {
      return [];
    }
  }
}