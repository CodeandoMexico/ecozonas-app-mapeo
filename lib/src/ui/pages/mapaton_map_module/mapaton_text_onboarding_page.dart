import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../bloc/bottom_navigation_bar_bloc.dart';
import '../../utils/constants.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_primary_elevated_button.dart';
import 'mapaton_onboarding_page.dart';

class MapatonTextOnboardingPage extends StatelessWidget implements BottomNavigationBarState {
  static const routeName = 'textOnboarding';

  const MapatonTextOnboardingPage({super.key});

  final _letterSpacing = 0.75;
  final _height = 1.5;
  final _style = const TextStyle(
    color: Constants.labelTextColor,
    fontSize: 16
  );

  @override
  Widget build(BuildContext context) {
    final showContinueButton = ModalRoute.of(context)!.settings.arguments as bool?;

    return Scaffold(
      appBar: MyAppBar(
        title: Image.asset(
          'assets/images/new_app_logo.png',
          height: 35,
        ),
        hideBackButton: showContinueButton != true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: _style.copyWith(
                    letterSpacing: _letterSpacing,
                    height: _height
                  ),
                  children: [
                    TextSpan(
                      text: '''${AppLocalizations.of(context)!.onboardingIntro1}

${AppLocalizations.of(context)!.onboardingIntro2}

${AppLocalizations.of(context)!.onboardingIntro3}\n\n'''
                    ),
                    _numberIndent(
                      1,
                      AppLocalizations.of(context)!.onboarding1
                    ),
                    _numberIndent(
                      2,
                      AppLocalizations.of(context)!.onboarding2
                    ),
                    // _letterIndent(
                    //   'a',
                    //   AppLocalizations.of(context)!.onboarding2a
                    // ),
                    // _letterIndent(
                    //   'b',
                    //   AppLocalizations.of(context)!.onboarding2b
                    // ),
                    // _letterIndent(
                    //   'c',
                    //   '${AppLocalizations.of(context)!.onboarding2b}\n'
                    // ),
                    _numberIndent(
                      3,
                      '${AppLocalizations.of(context)!.onboarding3}\n'
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context)!.aboutEcozonas}\n\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.onboardingOutro
                    )
                  ]
                ),
              ),
              if (showContinueButton == true) ...[
                const SizedBox(height: 20.0),
                MyPrimaryElevatedButton(
                  label: AppLocalizations.of(context)!.continueText,
                  fullWidth: true,
                  onPressed: () {
                    _goToMain(context);
                  },
                )
              ]
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /*
   * WIDGETS
   */
  WidgetSpan _numberIndent(int number, String text) {
    final style = _style.copyWith(
      letterSpacing: _letterSpacing,
      height: _height
    );

    return WidgetSpan(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. ', style: style),
          Flexible(child: Text(text, style: style))
        ],
      )
    );
  }

  WidgetSpan _letterIndent(String letter, String text) {
    final style = _style.copyWith(
      letterSpacing: _letterSpacing,
      height: _height
    );

    return WidgetSpan(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('    '),
          Text('$letter. ', style: style),
          Flexible(child: Text(text, style: style))
        ],
      )
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
          name: AppLocalizations.of(context)!.urbanEnvironment,
          code: "ENTORNO_URBANO",
          description: AppLocalizations.of(context)!.urbanEnvironmentText,
          color: "#D3D8EA",
          borderColor: "#6D7DBC",
          icon: "building"
        ),
        Category(
          uuid: "3a06b95b-a571-43fa-af49-62e38e3719bc",
          name: AppLocalizations.of(context)!.disasterRisk,
          code: "RIESGO_DESASTRES",
          description: AppLocalizations.of(context)!.disasterRiskText,
          color: "#F1D0D5",
          borderColor: "#DD4663",
          icon: "snowflake"
        ),
        Category(
          uuid: "a657288c-35ac-453c-a3e1-e283ed664929",
          name: AppLocalizations.of(context)!.environmentalQuality,
          code: "CALIDAD_MEDIOAMBIENTAL",
          description: AppLocalizations.of(context)!.environmentalQualityText,
          color: "#D3E9D3",
          borderColor: "#79C990",
          icon: "tree"
        ),
        Category(
          uuid: "d7dd49aa-d91d-4f46-8979-47cbbad56194",
          name: AppLocalizations.of(context)!.socioeconomicWellbeing,
          code: "BIENESTAR_SOCIOECONOMICO",
          description: AppLocalizations.of(context)!.socioeconomicWellbeingText,
          color: "#F7EDC8",
          borderColor: "#F0C23D",
          icon: "user"
        )
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
      updatedAt: DateTime.now()
    );

    Navigator.pushNamed(context, MapatonOnboardingPage.routeName, arguments: mapaton);
  }
}