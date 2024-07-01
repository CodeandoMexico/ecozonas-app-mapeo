import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/repositories/db/mapaton_data/mapaton_survey_repository_impl.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/models/survey_model.dart';
import '../../../domain/use_cases/db/mapaton_survey_use_case.dart';
import '../../../ui/utils/utils.dart' as utils;

class MapatonSurveyProvider with ChangeNotifier {
  late MapatonSurveyUseCase _useCase;
  
  List<MapatonModel> _mapatonList = [];
  List<MapatonModel> _originalMapatonList = [];

  List<SurveyModel> _surveyList = [];
  List<SurveyModel> _originalSurveyList = [];
  
  List<MapatonModel> get mapatons => _mapatonList;
  List<SurveyModel> get surveys => _surveyList;
  
  MapatonSurveyProvider() {
    _useCase = MapatonSurveyUseCase(MapatonSurveyRepositoryImpl());
    _getLists();
  }

  Future<void> _getLists() async {
    final mapatonData = await _useCase.getMapatonListData();
    if (mapatonData != null) {
      final j = json.decode(mapatonData) as List<dynamic>;
      _originalMapatonList = j.map((e) {
        return MapatonModel.fromJson(e);
      }).toList();
      _mapatonList = _originalMapatonList;
    }

    final surveyData = await _useCase.getSurveyListData();
    if (surveyData != null) {
      final j = json.decode(surveyData) as List<dynamic>;
      _originalSurveyList = j.map((e) {
        return SurveyModel.fromJson(e);
      }).toList();
      _surveyList = _originalSurveyList;
    }

    notifyListeners();
  }

  void setMapatonList(List<MapatonModel> list) {
    _originalMapatonList = list;
    _mapatonList = _originalMapatonList;

    notifyListeners();
  }

  void filterMapatonList(String query) {
    _mapatonList = _originalMapatonList.where((element) {
      final title = utils.removeDiacritics(element.title);
      final q = utils.removeDiacritics(query);

      return title.contains(q);
    }).toList();

    notifyListeners();
  }

  void setSurveyList(List<SurveyModel> list) {
    _originalSurveyList = list;
    _surveyList = _originalSurveyList;

    notifyListeners();
  }

  void filterSurveyList(String query) {
    _surveyList = _originalSurveyList.where((element) {
      final title = utils.removeDiacritics(element.title);
      final q = utils.removeDiacritics(query);

      return title.contains(q);
    }).toList();

    notifyListeners();
  }
}