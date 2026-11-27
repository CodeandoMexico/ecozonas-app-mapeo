import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:ecozonas/l10n/app_localizations.dart';
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
import '../../../utils/dialogs.dart' as dialogs;
import '../../../utils/utils.dart' as utils;
import '../../../widgets/ecozonas_image.dart';
import '../../../theme/theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/no_data_widget.dart';
import '../../mapaton_map_module/mapaton_map_page.dart';
import '../../mapaton_map_module/mapaton_more_info_page.dart';
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
      ),
    );
  }

  /*
   * APPBAR
   */
  AppBar _appBar(BuildContext context, MapatonSurveyProvider provider) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.diagnosticTools),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => _downloadAndSaveMapatons(context, provider),
          icon: const Icon(Icons.download),
        )
      ],
    );
  }

  /*
   * WIDGETS
   */
  Widget _body(BuildContext context, MapatonSurveyProvider provider) {
    if (provider.mapatons.isEmpty || provider.surveys.isEmpty) {
      return NoDataWidget(
        callback: () {
          _downloadAndSaveMapatons(context, provider);
        },
      );
    }

    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: AppSpacing.pageWithVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EcozonasImage(topPadding: AppSpacing.xs, bottomPadding: AppSpacing.lg),
          _toolCard(
            context,
            icon: Icons.assignment_outlined,
            title: l10n.answerTheSurvey,
            onPressed: () async => await launchUrl(Uri.parse(provider.surveys[0].surveyUrl)),
          ),
          const SizedBox(height: AppSpacing.sm),
          _toolCard(
            context,
            icon: Icons.map_outlined,
            title: l10n.mapYourNeighborhood,
            onPressed: () async => await _goToMapaton(provider.mapatons[0], context),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.checkResults, style: textTheme.titleSmall, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.checkResultsText,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: AppButton.outline(
              label: l10n.moreInfo,
              onPressed: () => Navigator.pushNamed(context, MapatonMoreInfoPage.routeName),
            ),
          ),
        ],
      ),
    );
  }

  /// Tarjeta de una herramienta de diagnóstico: ícono, título y botón.
  Widget _toolCard(BuildContext context, {required IconData icon, required String title, required VoidCallback onPressed}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.secondary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton.primary(
              label: AppLocalizations.of(context)!.start,
              onPressed: onPressed,
              fullWidth: true,
            ),
          ],
        ),
      ),
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
        utils.showSnackBarError(context, AppLocalizations.of(context)!.errorFound);
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
        utils.showSnackBarError(context, AppLocalizations.of(context)!.errorFound);
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
      // Navigator.pushNamed(context, MapatonMapPage.routeName, arguments: mapaton);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapatonMapPage(mapaton: mapaton),
        )
      );
    }
  }
}
