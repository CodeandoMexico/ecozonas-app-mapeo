import 'dart:io';

import 'package:ecozonas/src/domain/models/api_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:path/path.dart' as path;

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/apis/mapaton_survey_api_repository_impl.dart';
import '../../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../../domain/models/db/mapaton_db_model.dart';
import '../../../../domain/models/image_api_response_model.dart';
import '../../../../domain/models/mapaton_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/models/multipart_file_model.dart';
import '../../../../domain/use_cases/apis/mapaton_api_use_case.dart';
import '../../../../domain/use_cases/db/activity_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../../utils/constants.dart';
import 'bloc.dart';

class UpdateMapBloc extends Bloc<UpdateMapEvent, UpdateMapState> {
  UpdateMapBloc() : super(UpdateMapInitial()) {
    on<GetMapatons>((event, emit) => _mapGetMapatonsToState(emit));
    on<GetMapatonById>((event, emit) => _mapGetMapatonByIdToState(emit));
    on<SendMapaton>((event, emit) => _mapSendMapatonToState(emit, event.mapaton));
  }

  final _mapatonListController = BehaviorSubject<List<MapatonDbModel>>();
  final _mapatonController = BehaviorSubject<MapatonDbModel?>();

  Stream<List<MapatonDbModel>> get mapatonList => _mapatonListController.stream;
  Stream<MapatonDbModel?> get mapaton => _mapatonController.stream;
  
  Function(List<MapatonDbModel>) get setMapatonList => _mapatonListController.sink.add;
  Function(MapatonDbModel?) get setMapaton => _mapatonController.sink.add;

  dispose() {
    _mapatonListController.close();
    _mapatonController.close();
  }
  
  /*
   * MAP EVENTS TO STATES
   */
  void _mapGetMapatonsToState(Emitter<UpdateMapState> emit) async {
    emit(GettingMapatons());
    try {
      final mapatons = await _getMapatons();
      setMapatonList(mapatons);
      emit(MapatonsGetted());
    } catch (err) {
      emit(ErrorGettingMapatons());
    }
  }

  void _mapSendMapatonToState(Emitter<UpdateMapState> emit, MapatonDbModel mapaton) async {
    emit(SendingMapaton());
    try {
      final response = await _sendMapaton(mapaton);
      if (response.isSuccess) {
        await _updateSentActivities(mapaton);
        emit(MapatonSent());
      } else {
        emit(ErrorSendingMapaton(null));
      }
    } catch (err) {
      emit(ErrorSendingMapaton(err.toString()));
    }
  }

  void _mapGetMapatonByIdToState(Emitter<UpdateMapState> emit) async {
    emit(GettingMapatons());
    try {
      final mapaton = await _getMapatonById();
      setMapaton(mapaton);
      emit(MapatonsGetted());
    } catch (err) {
      emit(ErrorGettingMapatons());
    }
  }

  /*
   * METHODS
   */
  Future<List<MapatonDbModel>> _getMapatons() async {
    final useCase = MapatonUseCase(MapatonRepositoryImpl());
    return await useCase.getMapatons();
  }

  Future<MapatonDbModel?> _getMapatonById() async {
    final prefs = UserPreferences();
    final mapatonUseCase = MapatonUseCase(MapatonRepositoryImpl());
    final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
    
    final mapaton = await mapatonUseCase.getMapatonById(prefs.getMapatonDbId!);
    if (mapaton != null) {
      final activities = await activityUseCase.getActivitiesToSend(mapaton.id!);
      mapaton.activities = activities;

      return mapaton;
    } else {
      return null;
    }
  }
  
  Future<ApiResponseModel> _sendMapaton(MapatonDbModel mapaton) async {
    final prefs = UserPreferences();
    final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
    final activities = await activityUseCase.getActivitiesToSend(mapaton.id!);
    final s = prefs.getMapper!.sociodemographicData;
    mapaton.activities = activities;

    final postMapatonUseCase = MapatonSurveyApiUseCase(MapatonSurveyApiRepositoryImpl());

    for (var a in activities) {
      final blocks = blockListFromJson(a.blocks);
      blocks.removeWhere((element) {
        return element.blockType == 'instructions' ||
        element.blockType == 'point' ||
        element.blockType == 'line' ||
        element.blockType == 'polygon';
      });

      for (var b in blocks) {
        if (b.blockType == 'picture' && b.value != null) {
          final extension = path.extension(b.value);
          final name = DateTime.now().millisecondsSinceEpoch;

          final response = await postMapatonUseCase.postPhoto(MultipartFileModel(
            mapatonUuid: mapaton.uuid,
            field: 'image',
            bytes: File(b.value).readAsBytesSync(),
            filename: '$name$extension',
            path: b.value,
          ));

          if (response.isSuccess) {
            final image = imageApiResponseModelFromJson(response.result);
            b.value = image.uuid;
          } else {
            b.value = null;
          }
        }
      }

      a.blockList ??= [];
      a.blockList!.addAll(blocks);
    }

    final postMapaton = MapatonPostModel(
      mapper: Mapper(
        id: prefs.getMapper!.id,
        sociodemographicData: SociodemographicData(
          gender: Constants.gender.firstWhere((e) => e.label == s.gender).value,
          ageRange: Constants.ageRange.firstWhere((e) => e.label == s.ageRange).value,
          disability: Constants.disability.firstWhere((e) => e.label == s.disability).value,
        )
      ),
      activities: activities.map((e) {
        return PostActivity(
          uuid: e.uuid,
          geometry: Geometry(
            type: 'point',
            coordinates: GeometryLatLng(
              latitude: e.latitude,
              longitude: e.longitude
            )
          ),
          timestamp: e.timestamp,
          data: { for (var v in e.blockList!) v.uuid : v.value }
        );
      }).toList()
    );
    
    return await postMapatonUseCase.sendMapaton(postMapaton);
  }

  Future _updateSentActivities(MapatonDbModel mapaton) async {
    final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
    await activityUseCase.updateSentActivities(mapaton.id!);
  }
}