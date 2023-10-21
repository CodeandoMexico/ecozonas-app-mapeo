import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/apis/post_mapaton_repository_impl.dart';
import '../../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../../domain/models/db/mapaton_db_model.dart';
import '../../../../domain/models/mapaton_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/use_cases/apis/post_mapaton_use_case.dart';
import '../../../../domain/use_cases/db/activity_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_use_case.dart';
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
      await _sendMapaton(mapaton);
      emit(MapatonSent());
    } catch (err) {
      emit(ErrorSendingMapaton());
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
    
    final mapaton = await mapatonUseCase.getMapatonById(prefs.getMapatonId!);
    if (mapaton != null) {
      final activities = await activityUseCase.getMapatonActivities(mapaton.id!);
      mapaton.activities = activities;

      return mapaton;
    } else {
      return null;
    }
  }
  
  Future<void> _sendMapaton(MapatonDbModel mapaton) async {
    final prefs = UserPreferences();
    final activityUseCase = ActivityUseCase(ActivityRepositoryImpl());
    final activities = await activityUseCase.getMapatonActivities(mapaton.id!);
    mapaton.activities = activities;

    final postMapaton = MapatonPostModel(
      mapper: Mapper(
        id: prefs.getMapper!.id,
        sociodemographicData: SociodemographicData(
          genre: prefs.getMapper!.sociodemographicData.genre,
          ageRange: prefs.getMapper!.sociodemographicData.ageRange,
          disability: prefs.getMapper!.sociodemographicData.disability
        )
      ),
      mapaton: MapatonActivities(
        uuid: mapaton.uuid,
        activities: activities.map((e) {
          List<Block> blocks = blockListFromJson(e.blocks);
          blocks.removeWhere((element) {
            return element.blockType == 'INSTRUCTIONS' ||
            element.blockType == 'POINT' ||
            element.blockType == 'LINE' ||
            element.blockType == 'POLYGON';
          });

          debugPrint('Count: ${blocks.length}');
          debugPrint(blocks.toString());
          
          return PostActivity(
            uuid: e.uuid,
            location: LatLng(e.latitude, e.longitude),
            timestamp: e.timestamp,
            blocks: blocks.map((b) {
              return AnswerBlock(uuid: b.uuid, answer: b.value);
            }).toList()
          );
        }).toList()
      )
    );

    final postMapatonUseCase = PostMapatonUseCase(PostMapatonRepositoryImpl());
    await postMapatonUseCase.sendMapaton(postMapaton);
  }
}