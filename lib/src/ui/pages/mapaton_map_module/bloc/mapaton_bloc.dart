import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../main.dart';
import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../../data/repositories/location/location_repository_impl.dart';
import '../../../../domain/models/current_activity_model.dart';
import '../../../../domain/models/db/activity_db_model.dart';
import '../../../../domain/use_cases/db/activity_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../../../domain/use_cases/location_use_case.dart';
import 'bloc.dart';

class MapatonBloc extends Bloc<MapatonEvent, MapatonState> {
  final _location = Location();

  MapatonBloc() : super(MapatonInitial()) {
    on<GetLocation>((event, emit) => _mapGetLocationToState(emit));
    on<GetMarkers>((event, emit) => _mapGetMarkersToState(emit, event.uuid));
    on<AddMarker>((event, emit) => _mapAddMarkerToState(emit, event.activity));
    on<RemoveMarker>((event, emit) => _mapRemoveMarkerToState(emit, event.activity));
    on<ShowCenter>((event, emit) => _mapShowCenterToState(emit, event.showCenter));
    on<ShowDownload>((event, emit) => _mapShowDownloadToState(emit, event.show));
    on<DownloadRegion>((event, emit) => _mapDownloadRegionToState(emit, event.name, event.bounds));
    on<SetCurrentActivity>((event, emit) => _mapSetCurrentActivityToState(emit, event.activity));
  }

  final _cameraPositionController = BehaviorSubject<LatLng>();
  final _activitiesController = BehaviorSubject<List<ActivityDbModel>>.seeded([]);
  final _showCenterController = BehaviorSubject<bool>.seeded(true);
  final _showDownloadController = BehaviorSubject<bool>.seeded(true);
  final _currentActiivityNameController = BehaviorSubject<CurrentActivityModel?>();

  Stream<LatLng> get cameraPosition => _cameraPositionController.stream;
  Stream<LocationData> get currentPosition => _location.onLocationChanged;
  Stream<List<ActivityDbModel>> get activities => _activitiesController.stream;
  Stream<bool> get showCenter => _showCenterController.stream;
  Stream<bool> get showDownload => _showDownloadController.stream;
  Stream<CurrentActivityModel?> get currentActivity => _currentActiivityNameController.stream;

  List<ActivityDbModel> get activitiesValue => _activitiesController.stream.value;
  bool get showCenterValue => _showCenterController.stream.value;
  
  Function(LatLng) get setCameraPosition => _cameraPositionController.sink.add;
  Function(List<ActivityDbModel>) get setActivities => _activitiesController.sink.add;
  Function(bool) get setShowCenter => _showCenterController.sink.add;
  Function(bool) get setShowDownload => _showDownloadController.sink.add;
  Function(CurrentActivityModel?) get setCurrentActivity => _currentActiivityNameController.sink.add;

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
      emit(MarkersGetted(activities: markers));
    } catch (err) {
      emit(ErrorGettingMarkers());
    }
  }

  void _mapAddMarkerToState(Emitter<MapatonState> emit, ActivityDbModel activity) async {
    final list = activitiesValue.toList();
    list.add(activity);
    setActivities(list);
    emit(MarkerAdded(activity: activity));
  }

  void _mapRemoveMarkerToState(Emitter<MapatonState> emit, ActivityDbModel activity) async {
    await _removeActivity(activity);

    final list = activitiesValue.toList();
    list.removeWhere((element) {
      return element.id == activity.id;
    });
    setActivities(list);
  }

  void _mapShowCenterToState(Emitter<MapatonState> emit, bool showCenter) async {
    setShowCenter(showCenter);
  }

  void _mapShowDownloadToState(Emitter<MapatonState> emit, bool show) async {
    setShowDownload(show);
  }

  void _mapDownloadRegionToState(Emitter<MapatonState> emit, String name, LatLngBounds bounds) async {
    emit(DownloadingRegion());
    try {
       await _downloadRegion(bounds, name);
      emit(RegionDownloaded());
    } catch (err) {
      emit(ErrorDownloadingRegion());
    }
  }

  void _mapSetCurrentActivityToState(Emitter<MapatonState> emit, CurrentActivityModel? activity) async {
    setCurrentActivity(activity);
  }

  /*
   * METHODS
   */
  Future<LatLng?> _getLocation() async {
    final useCase = LocationUseCase(LocationRepositoryImpl(_location));
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
      final response = await activityUseCase.getMapatonActivities(mapaton.id!);
      return response;
    } else {
      return [];
    }
  }

  Future<List<ActivityDbModel>> getMarkers(String uuid) async {
    return _getMarkers(uuid);
  }

  Future<int> _removeActivity(ActivityDbModel activity) async {
    final useCase = ActivityUseCase(ActivityRepositoryImpl());
    return await useCase.removeActivity(activity);
  }

  Future<void> _downloadRegion(LatLngBounds bounds, String name) async {
    await downloadOfflineRegion(
      OfflineRegionDefinition(
        bounds: LatLngBounds(
          northeast: bounds.northeast,
          southwest: bounds.southwest,
        ),
        minZoom: 10.0,
        maxZoom: 16.0,
        mapStyleUrl: MapboxStyles.MAPBOX_STREETS,
      ),
      metadata: {
        'name': name,
      },
      accessToken: MyApp.accessToken
    );
  }
}