import 'package:flutter/material.dart';

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
                    const TextSpan(
                      text: '''
Las EcoZonas son un tipo de barrio que fomenta la colaboración y solidaridad, la sostenibilidad y la prosperidad.

Esta aplicación te permitirá identificar los desafíos y oportunidades de tu barrio en cuatro dimensiones: Entorno urbano, Calidad ambiental, Bienestar socioeconómico y Riesgo de Desastres, a través de dos herramientas: una encuesta barrial y mapeo colaborativo.

Los resultados de este ejercicio generarán un reporte con los principales desafíos y oportunidades, así como opciones de Soluciones Urbanas Sostenibles (SUS) de rápida implementación y bajo costo. Por último, proporciona un plan de acción a mediano y largo plazo, para abordar los principales problemas. Puedes visualizar y descargar los resultados y el reporte en el tablero, en el que también encontrarás una biblioteca con varios recursos sobre cómo aplicar las SUS priorizadas para tu comunidad. Toda la información sobre la metodología de EcoZonas la encuentras aquí. 

Puedes utilizar las herramientas por separado, pero para obtener un diagnóstico completo, te sugerimos que:\n\n'''
                    ),
                    _numberIndent(
                      1,
                      'Completes la encuesta para identificar los principales desafíos y oportunidades en tu comunidad. Una vez que un número importante de personas vecinas de tu comunidad hayan respondido la encuesta, podrás descargar el reporte con el diagnóstico y posibles soluciones aquí.\n'
                    ),
                    _numberIndent(
                      2,
                      'Mapees los principales desafíos y oportunidades en tu barrio para saber donde están y poder solucionarlos.'
                    ),
                    _letterIndent(
                      'a',
                      'Selecciona el punto que quieres mapear. Puede ser un lugar (plaza, negocio, etc), un elemento (estacionamientos de bicicleta, paradas de buses) o un evento (riesgo de inundación, actividad deportiva). Si el elemento no existe, puedes incorporar tus sugerencias.'
                    ),
                    _letterIndent(
                      'b',
                      'Completa la información requerida. ¿Es seguro? ¿En qué estado se encuentra? ¿Cuáles son sus impactos? ¡Puedes agregar fotografías!'
                    ),
                    _letterIndent(
                      'c',
                      'Envía la información y continúa tu mapeo\n'
                    ),
                    _numberIndent(
                      3,
                      'Una vez completados los pasos anteriores, visualiza y descarga el reporte con el diagnóstico y las soluciones priorizadas aquí\n'
                    ),
                    const TextSpan(
                      text: 'Sobre Ecozonas\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    const TextSpan(
                      text: 'El proyecto “EcoZonas: Una metodología para co-diseñar, escalar y replicar la acción climática inclusiva a nivel de barrio” es implementado por WRI México y el Instituto Wuppertal de Clima, Medio Ambiente y Energía, y fomentado por el Ministerio Federal de Economía y Protección del Clima Alemán y la Iniciativa Internacional del Clima IKI.'
                    )
                  ]
                ),
              ),
              if (showContinueButton == true) ...[
                const SizedBox(height: 20.0),
                MyPrimaryElevatedButton(
                  label: 'Continuar',
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
          name: "Entorno urbano",
          code: "ENTORNO_URBANO",
          description: "Son los elementos que se encuentran en un barrio y que permiten que funcione, como espacios públicos (plazas, parques y jardines), el transporte público, calles en las que se pueda caminar o andar en bicicleta, las escuelas, centros de salud, comercios, y más. Un entorno urbano es adecuado cuando es seguro, todas las personas son bienvenidas y se cuida el medio ambiente.",
          color: "#deecfd",
          borderColor: "#6a94c6",
          icon: "building"
        ),
        Category(
          uuid: "3a06b95b-a571-43fa-af49-62e38e3719bc",
          name: "Riesgo de desastres",
          code: "RIESGO_DESASTRES",
          description: "Identifica los efectos negativos y los impactos sobre las personas, las viviendas y los negocios a los que se enfrenta un barrio en caso de fenómenos naturales y desastres, tales como inundaciones, olas de calor o incendios. Una comunidad que se prepara para estos riesgos puede protegerse y recuperarse de ellos más fácilmente.",
          color: "#f8d8e0",
          borderColor: "#d46e87",
          icon: "snowflake"
        ),
        Category(
          uuid: "a657288c-35ac-453c-a3e1-e283ed664929",
          name: "Calidad medioambiental",
          code: "CALIDAD_MEDIOAMBIENTAL",
          description: "Las características ambientales de un barrio incluyen las prácticas y situaciones que impactan en la salud de la población.  Por ejemplo, se refieren a la limpieza del aire o dell agua, cómo se maneja la basura o si hay lugares sucios o contaminados en el barrio.",
          color: "#d8e9d4",
          borderColor: "#4fa163",
          icon: "tree"
        ),
        Category(
          uuid: "d7dd49aa-d91d-4f46-8979-47cbbad56194",
          name: "Bienestar Socioeconómico",
          code: "BIENESTAR_SOCIOECONOMICO",
          description: "El bienestar socioeconómico identifica las oportunidades para tener un trabajo, poder estudiar, saber lo que pasa y estar sanos. También incluye el que todas las personas puedan participar en actividades que les generen ingresos y en eventos que les hagan sentir parte de la comunidad.",
          color: "#fcf0db",
          borderColor: "#d2ad51",
          icon: "user"
        )
      ],
      activities: [],
      uuid: '',
      title: 'Mapeo Libre',
      locationText: 'Mapeo para cualquier ubicación.',
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