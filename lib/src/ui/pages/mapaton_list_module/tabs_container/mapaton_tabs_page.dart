// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../../data/repositories/apis/mapaton_survey_api_repository_impl.dart';
// import '../../../../data/repositories/db/mapaton_data/mapaton_survey_repository_impl.dart';
// import '../../../../domain/models/db/mapaton_data_db_model.dart';
// import '../../../../domain/models/db/survey_data_db_model.dart';
// import '../../../../domain/models/mapaton_model.dart';
// import '../../../../domain/models/survey_model.dart';
// import '../../../../domain/use_cases/apis/mapaton_api_use_case.dart';
// import '../../../../domain/use_cases/db/mapaton_survey_use_case.dart';
// import '../../../bloc/bottom_navigation_bar_bloc.dart';
// import '../../../utils/constants.dart';
// import '../../../utils/dialogs.dart' as dialogs;
// import '../../../utils/utils.dart' as utils;
// import '../mapaton_survey_provider.dart';
// import '../mapaton_list_tab/mapaton_list_page.dart';
// import '../survey_list_tab/survey_list_page.dart';

// class MapatonTabsPage extends StatelessWidget implements BottomNavigationBarState {
//   static const routeName = 'mapatonList';

//   const MapatonTabsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MapatonSurveyProvider>(context);

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: _appBar(context, provider),
//         body: _body(),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }

//   /*
//    * APPBAR
//    */
//   AppBar _appBar(BuildContext context, MapatonSurveyProvider provider) {
//     return AppBar(
//       title: Text(AppLocalizations.of(context)!.diagnosticTools),
//       titleSpacing: 0,
//       centerTitle: true,
//       leading: Container(),
//       bottom: TabBar(
//         indicatorColor: Constants.darkBlueColor,
//         indicatorWeight: 3,
//         tabs: [
//           _tab(AppLocalizations.of(context)!.survey),
//           _tab(AppLocalizations.of(context)!.mapping)
//         ],
//       ),
//       elevation: 0,
//       iconTheme: const IconThemeData(
//         color: Colors.black
//       ),
//       actions: [
//         IconButton(
//           onPressed: () => _downloadAndSaveMapatons(context, provider),
//           icon: const Icon(Icons.download)
//         )
//       ],
//     );
//   }

//   /*
//    * WIDGETS
//    */
//   Widget _body() {
//     return const TabBarView(
//       children: [
//         SurveyListPage(),
//         MapatonListPage()
//       ],
//     );
//   }

//   Widget _tab(String label) {
//     return Tab(
//       child: Text(
//         label,
//         style: const TextStyle(fontSize: 18, color: Constants.labelTextColor)
//       )
//     );
//   }

//   /*
//    * METHODS
//    */
//   Future<void> _downloadAndSaveMapatons(BuildContext context, MapatonSurveyProvider provider) async {
//     final apiUseCase = MapatonSurveyApiUseCase(MapatonSurveyApiRepositoryImpl());
    
//     dialogs.showLoadingDialog(context);

//     /*
//      * Mapaton
//      */
//     final mapatonResponse = await apiUseCase.getMapatonList();
//     final localUseCase = MapatonSurveyUseCase(MapatonSurveyRepositoryImpl());

//     if (mapatonResponse.isSuccess) {
//       final localMapatonData = await localUseCase.getMapatonListData();
//       if (localMapatonData == null) {
//         await localUseCase.addMapatonListData(MapatonDataDbModel(data: json.encode(mapatonResponse.result)));
//         provider.setMapatonList(mapatonListFromJson(json.encode(mapatonResponse.result)));
//       } else {
//         await localUseCase.updateMapatonListData(
//           MapatonDataDbModel(
//             id: 1,
//             data: json.encode(mapatonResponse.result)
//           )
//         );
//         provider.setMapatonList(mapatonListFromJson(json.encode(mapatonResponse.result)));
//       }
//     } else {
//       if (context.mounted) {
//         utils.showSnackBarError(context, mapatonResponse.error!);
//       }  
//     }

//     /*
//      * Survey
//      */
//     final surveyResponse = await apiUseCase.getSurveyList();

//     if (surveyResponse.isSuccess) {
//       final localData = await localUseCase.getSurveyListData();
//       if (localData == null) {
//         await localUseCase.addSurveyListData(SurveyDataDbModel(data: json.encode(surveyResponse.result)));
//         provider.setSurveyList(surveyListFromJson(json.encode(surveyResponse.result)));
//       } else {
//         await localUseCase.updateSurveyListData(
//           SurveyDataDbModel(
//             id: 1,
//             data: json.encode(surveyResponse.result)
//           )
//         );
//         provider.setSurveyList(surveyListFromJson(json.encode(surveyResponse.result)));
//       }
//     } else {
//       if (context.mounted) {
//         utils.showSnackBarError(context, surveyResponse.error!);
//       }  
//     }
    
//     if (context.mounted) {
//       Navigator.pop(context);
//     }
//   }
// }


/*
 * QUITAR TABS
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/apis/mapaton_survey_api_repository_impl.dart';
import '../../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../../data/repositories/db/mapaton_data/mapaton_survey_repository_impl.dart';
import '../../../../domain/models/db/mapaton_data_db_model.dart';
import '../../../../domain/models/db/mapaton_db_model.dart';
import '../../../../domain/models/db/survey_data_db_model.dart';
import '../../../../domain/models/mapaton_model.dart';
import '../../../../domain/models/survey_model.dart';
import '../../../../domain/use_cases/apis/mapaton_api_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_survey_use_case.dart';
import '../../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../../bloc/bottom_navigation_bar_bloc.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialogs.dart' as dialogs;
import '../../../utils/utils.dart' as utils;
import '../../../widgets/my_primary_elevated_button.dart';
import '../../../widgets/no_data_widget.dart';
import '../../mapaton_map_module/mapaton_map_page.dart';
import '../mapaton_survey_provider.dart';

class MapatonTabsPage extends StatelessWidget implements BottomNavigationBarState {
  static const routeName = 'mapatonList';

  const MapatonTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapatonSurveyProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(context, provider),
        body: _body(context, provider),
        backgroundColor: Colors.white,
      ),
    );
  }

  /*
   * APPBAR
   */
  AppBar _appBar(BuildContext context, MapatonSurveyProvider provider) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.diagnosticTools),
      titleSpacing: 0,
      centerTitle: true,
      leading: Container(),
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
  Widget _body(BuildContext context, MapatonSurveyProvider provider) {
    return provider.mapatons.isNotEmpty && provider.surveys.isNotEmpty ? Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall, horizontal: Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.answerTheSurvey, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF646464))),
          const SizedBox(height: Constants.paddingSmall),
          Card(
            color: const Color(0xFFECECEC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFB6B6B6), width: 1)
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.padding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(provider.surveys[0].title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  MyPrimaryElevatedButton(
                    label: AppLocalizations.of(context)!.goToSurvey,
                    onPressed: () async => await launchUrl(Uri.parse(provider.surveys[0].surveyUrl))
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(AppLocalizations.of(context)!.mapYourNeighborhood, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF646464))),
          const SizedBox(height: Constants.paddingSmall),
          Card(
            color: const Color(0xFFECECEC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFB6B6B6), width: 1)
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.padding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(utils.showEnglish(context) && provider.mapatons[0].titleEn != null ? provider.mapatons[0].titleEn! : provider.mapatons[0].title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(provider.mapatons[0].locationText),
                        MyPrimaryElevatedButton(
                          label: AppLocalizations.of(context)!.mapOut,
                          onPressed: () async {
                            await _goToMapaton(provider.mapatons[0], context);
                          }
                        )
                      ],
                    ),
                  ),
                  Image.asset('assets/images/map_placeholder.jpg', height: 80)
                ],
              ),
            ),
          )
        ],
      ),
    ) : NoDataWidget(
      callback: () {
        _downloadAndSaveMapatons(context, provider);
      },
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

  Future<void> _goToMapaton(MapatonModel mapaton, BuildContext context) async {
    final prefs = UserPreferences();
    final mapper = prefs.getMapper;
    
    final useCase = MapatonUseCase(MapatonRepositoryImpl());
    final m = await useCase.getMapatonsByUuidAndMapper(mapaton.uuid, mapper!.id.toString());
    
    if (m == null) {
      final id = await useCase.addMapaton(MapatonDbModel(
        uuid: mapaton.uuid,
        dateTime: DateTime.now(),
        mapperId: mapper.id,
        mapperGender: mapper.sociodemographicData.gender,
        mapperAge: mapper.sociodemographicData.ageRange,
        mapperDisability: mapper.sociodemographicData.disability,
      ));
      prefs.setMapatonDbId = id;
    } else {
      prefs.setMapatonDbId = m.id;
    }
    
    if (context.mounted) {
      Navigator.pushNamed(context, MapatonMapPage.routeName, arguments: mapaton);
    }
  }
}