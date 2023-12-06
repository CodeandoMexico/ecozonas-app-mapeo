import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/apis/mapaton_survey_api_repository_impl.dart';
import '../../../../data/repositories/db/mapaton_data/mapaton_survey_repository_impl.dart';
import '../../../../domain/models/db/mapaton_data_db_model.dart';
import '../../../../domain/models/db/survey_data_db_model.dart';
import '../../../../domain/models/mapaton_model.dart';
import '../../../../domain/models/survey_model.dart';
import '../../../../domain/use_cases/apis/mapaton_api_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_survey_use_case.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialogs.dart' as dialogs;
import '../../../utils/utils.dart' as utils;
import '../mapaton_survey_provider.dart';
import '../mapaton_list_tab/mapaton_list_page.dart';
import '../survey_list_tab/survey_list_page.dart';

class MapatonTabsPage extends StatelessWidget {
  static const routeName = 'mapatonList';

  const MapatonTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapatonSurveyProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(context, provider),
          body: _body(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  /*
   * APPBAR
   */
  AppBar _appBar(BuildContext context, MapatonSurveyProvider provider) {
    return AppBar(
      title: const Text('Herramientas de diagnóstico'),
      titleSpacing: 0,
      centerTitle: true,
      bottom: TabBar(
        indicatorColor: Constants.darkBlueColor,
        indicatorWeight: 3,
        tabs: [
          _tab('Mapeo'),
          _tab('Encuesta')
        ],
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
      actions: [
        IconButton(
          onPressed: () => _downloadAndSaveMapatons(context, provider),
          icon: const Icon(Icons.download)
        )
      ],
    );
  }

  /*
   * WIDGETS
   */
  Widget _body() {
    return const TabBarView(
      children: [
        MapatonListPage(),
        SurveyListPage()
      ],
    );
  }

  Widget _tab(String label) {
    return Tab(
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Constants.labelTextColor)
      )
    );
  }

  /*
   * METHODS
   */
  Future<void> _downloadAndSaveMapatons(BuildContext context, MapatonSurveyProvider provider) async {
    final apiUseCase = MapatonSurveyApiUseCase(MapatonSurveyApiRepositoryImpl());
    
    dialogs.showLoadingDialog(context);

    /*
     * Mapaton
     */
    final mapatonResponse = await apiUseCase.getMapatonList();
    final localUseCase = MapatonSurveyUseCase(MapatonSurveyRepositoryImpl());

    if (mapatonResponse.isSuccess) {
      final localMapatonData = await localUseCase.getMapatonListData();
      if (localMapatonData == null) {
        await localUseCase.addMapatonListData(MapatonDataDbModel(data: json.encode(mapatonResponse.result)));
        provider.setMapatonList(mapatonListFromJson(json.encode(mapatonResponse.result)));
      } else {
        await localUseCase.updateMapatonListData(
          MapatonDataDbModel(
            id: 1,
            data: json.encode(mapatonResponse.result)
          )
        );
        provider.setMapatonList(mapatonListFromJson(json.encode(mapatonResponse.result)));
      }
    } else {
      if (context.mounted) {
        utils.showSnackBarError(context, mapatonResponse.error!);
      }  
    }

    /*
     * Survey
     */
    final surveyResponse = await apiUseCase.getSurveyList();

    if (surveyResponse.isSuccess) {
      final localData = await localUseCase.getSurveyListData();
      if (localData == null) {
        await localUseCase.addSurveyListData(SurveyDataDbModel(data: json.encode(surveyResponse.result)));
        provider.setSurveyList(surveyListFromJson(json.encode(surveyResponse.result)));
      } else {
        await localUseCase.updateSurveyListData(
          SurveyDataDbModel(
            id: 1,
            data: json.encode(surveyResponse.result)
          )
        );
        provider.setSurveyList(surveyListFromJson(json.encode(surveyResponse.result)));
      }
    } else {
      if (context.mounted) {
        utils.showSnackBarError(context, surveyResponse.error!);
      }  
    }
    
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}