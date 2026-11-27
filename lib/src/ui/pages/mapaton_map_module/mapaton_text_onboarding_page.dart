import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../bloc/bottom_navigation_bar_bloc.dart';
import '../../widgets/my_app_bar.dart';
import '../../theme/theme.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_numbered_text.dart';
import 'mapaton_onboarding_page.dart';

class MapatonTextOnboardingPage extends StatelessWidget implements BottomNavigationBarState {
  static const routeName = 'textOnboarding';

  const MapatonTextOnboardingPage({super.key});


  @override
  Widget build(BuildContext context) {
    final showContinueButton = ModalRoute.of(context)!.settings.arguments as bool?;
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MyAppBar(
        title: Image.asset('assets/images/new_app_logo.png', height: 32),
        hideBackButton: showContinueButton != true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pageWithVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.onboardingIntro1, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.onboardingIntro2, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.onboardingIntro3, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            _numberedItem(context, 1, l10n.onboarding1),
            _numberedItem(context, 2, l10n.onboarding2),
            // Pasos 2a-2c, desactivados: _letteredItem(context, 'a', l10n.onboarding2a), …
            _numberedItem(context, 3, l10n.onboarding3),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.aboutEcozonas, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.onboardingOutro, style: textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary)),
            if (showContinueButton == true) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton.primary(
                label: l10n.continueText,
                fullWidth: true,
                onPressed: () => _goToMain(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _numberedItem(BuildContext context, int number, String text) {
    return AppNumberedText(marker: '$number.', text: text);
  }

  // Se usa en los pasos 2a-2c de la introducción, que están comentados.
  // ignore: unused_element
  Widget _letteredItem(BuildContext context, String letter, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg),
      child: AppNumberedText(marker: '$letter.', text: text),
    );
  }

  /*
   * METHODS
   */
  void _goToMain(BuildContext context) {
    final mapaton = MapatonModel(
        categories: [
          Category(
              uuid: "644c2ebe-a82e-4c23-a111-7bdc6f95e09d",
              name:
                  AppLocalizations.of(context)!.urbanEnvironment.toLowerCase(),
              code: "ENTORNO_URBANO",
              description: AppLocalizations.of(context)!.urbanEnvironmentText,
              color: "#D3D8EA",
              borderColor: "#6D7DBC",
              icon: "building"),
          Category(
              uuid: "3a06b95b-a571-43fa-af49-62e38e3719bc",
              name: AppLocalizations.of(context)!.disasterRisk.toLowerCase(),
              code: "RIESGO_DESASTRES",
              description: AppLocalizations.of(context)!.disasterRiskText,
              color: "#F1D0D5",
              borderColor: "#DD4663",
              icon: "snowflake"),
          Category(
              uuid: "a657288c-35ac-453c-a3e1-e283ed664929",
              name: AppLocalizations.of(context)!
                  .environmentalQuality
                  .toLowerCase(),
              code: "CALIDAD_AMBIENTAL",
              description:
                  AppLocalizations.of(context)!.environmentalQualityText,
              color: "#D3E9D3",
              borderColor: "#79C990",
              icon: "tree"),
          Category(
              uuid: "d7dd49aa-d91d-4f46-8979-47cbbad56194",
              name: AppLocalizations.of(context)!
                  .socioeconomicWellbeing
                  .toLowerCase(),
              code: "BIENESTAR_SOCIOECONOMICO",
              description:
                  AppLocalizations.of(context)!.socioeconomicWellbeingText,
              color: "#F7EDC8",
              borderColor: "#F0C23D",
              icon: "user")
        ],
        activities: [],
        uuid: '',
        title: AppLocalizations.of(context)!.freeMapping,
        locationText: AppLocalizations.of(context)!.mappingForAnyLocation,
        limitNorth: '',
        limitSouth: '',
        limitEast: '',
        limitWest: '',
        createdAt: DateTime.now(),
        status: '',
        updatedAt: DateTime.now());

    Navigator.pushNamed(context, MapatonOnboardingPage.routeName, arguments: mapaton);
  }
}
