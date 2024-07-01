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
          'assets/images/ecozonas_logo.png',
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

                    // ESPAÑOL
                    // HECHO - "Las EcoZonas son barrios que promueven colaboración, sostenibilidad y prosperidad. Esta aplicación te ayudará a identificar los desafíos y oportunidades en tu barrio en cuatro dimensiones: entorno urbano, calidad ambiental, bienestar socioeconómico y riesgo de desastres.
                    // HECHO - Realiza la encuesta barrial y el mapeo colaborativo para identificar estos desafíos. Los resultados generarán un reporte de tu barrio junto con una priorización de Soluciones Urbanas Sostenibles (SUS) de rápida implementación y bajo costo para tu comunidad. Podrás visualizar y descargar este reporte en la página  www.ecozonas.org, junto con otros recursos y detalles sobre las Soluciones Urbanas Sostenibles.
                    // HECHO - Para un diagnóstico completo, sigue estos pasos:
                    // HECHO - 1. Completa la encuesta y anima a otras personas a hacerlo.
                    // HECHO - 2. Mapea los desafíos y oportunidades en tu barrio y envía la información.
                    // HECHO - 3. Descarga el reporte con el diagnóstico y las soluciones en la página www.ecozonas.org
                    
                    // HECHO - Esta herramienta es parte del proyecto ""EcoZonas"", implementado por WRI México y el Instituto Wuppertal, apoyado por el Ministerio Federal de Economía y Protección del Clima Alemán y la Iniciativa Internacional del Clima (IKI)."

                    // INGLES
                    // HECHO - EcoZones are neighborhoods that promote collaboration, sustainability, and prosperity. This app will help you identify the challenges and opportunities in your neighborhood across four dimensions: urban environment, environmental quality, socioeconomic well-being, and disaster risk.
                    // HECHO - Complete the neighborhood survey and collaborative mapping to identify these challenges. The results will generate a report for your neighborhood, prioritizing Sustainable Urban Solutions (SUS) of short-term and low-cost implementation that can be applied in your community. You can view and download this report on the website: www.ecozonas.org, along with other resources and a catalogue of Sustainable Urban Solutions.
                    // HECHO - For a complete assessment, follow these steps:
                    // HECHO - 1. Complete the survey and encourage others to do it as well.
                    // HECHO - 2. Map the challenges and opportunities in your neighborhood and submit the information.
                    // HECHO - 3. Download the report with the diagnosis and solutions from the website www.ecozonas.org.
                    //
                    // HECHO - This tool is part of the "EcoZones" project, implemented by WRI Mexico and the Wuppertal Institute, supported by the German Federal Ministry for Economic Affairs and Climate Action and the International Climate Initiative (IKI).


                    TextSpan(
                      text: '''${AppLocalizations.of(context)!.onboardingIntro1}

${AppLocalizations.of(context)!.onboardingIntro2}

${AppLocalizations.of(context)!.onboardingIntro3}\n\n'''
                    ),
                    _numberIndent(
                      1,
                      '${AppLocalizations.of(context)!.onboarding1}\n'
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
          color: "#deecfd",
          borderColor: "#6a94c6",
          icon: "building"
        ),
        Category(
          uuid: "3a06b95b-a571-43fa-af49-62e38e3719bc",
          name: AppLocalizations.of(context)!.disasterRisk,
          code: "RIESGO_DESASTRES",
          description: AppLocalizations.of(context)!.disasterRiskText,
          color: "#f8d8e0",
          borderColor: "#d46e87",
          icon: "snowflake"
        ),
        Category(
          uuid: "a657288c-35ac-453c-a3e1-e283ed664929",
          name: AppLocalizations.of(context)!.environmentalQuality,
          code: "CALIDAD_MEDIOAMBIENTAL",
          description: AppLocalizations.of(context)!.environmentalQualityText,
          color: "#d8e9d4",
          borderColor: "#4fa163",
          icon: "tree"
        ),
        Category(
          uuid: "d7dd49aa-d91d-4f46-8979-47cbbad56194",
          name: AppLocalizations.of(context)!.socioeconomicWellbeing,
          code: "BIENESTAR_SOCIOECONOMICO",
          description: AppLocalizations.of(context)!.socioeconomicWellbeingText,
          color: "#fcf0db",
          borderColor: "#d2ad51",
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