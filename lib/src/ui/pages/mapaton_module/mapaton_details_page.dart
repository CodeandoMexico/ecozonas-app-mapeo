import 'package:ecozonas/src/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../styles/my_button_styles.dart';
import '../../utils/constants.dart';
import 'mapaton_map_page.dart';

class MapatonDetailsPage extends StatelessWidget {
  static const routeName = 'mapatonDetails';

  MapatonDetailsPage({super.key});

  final details = [
    'Infraestructura',
    'Accesibilidad y planificación urbana',
    'Calidad de las vías',
    'Disponibilidad de espacios verdes',
    'Distribución de servicios públicos',
    'Conectividad',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _header(context),
          const SizedBox(height: Constants.paddingXLarge),
          _sectionTitle(),
          const SizedBox(height: Constants.paddingXLarge),
          _details(),
          const Spacer(),
          _buttons(context)
        ],
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  /*
   * APP BAR
   */
  AppBar _appBar() {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.map),
          SizedBox(width: Constants.paddingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('La Metalera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Hermosillo, Sonora', style: TextStyle(fontSize: 14)),
            ],
          )
        ],
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      color: const Color(0xFF6A94C6),
      padding: const EdgeInsets.all(Constants.padding),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Dimensiones evaluadas durante el mapeo',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
          Icon(Icons.business_outlined, size: 120, color: Color(0xFF29496E)),
        ],
      ),
    );
  }

  Text _sectionTitle() => const Text(
    'Entorno urbano',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Color(0xFF29496E))
  );

  Widget _details() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details.map((e) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text('\u2022 \t $e', style: const TextStyle(fontSize: 16)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(Constants.padding),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: MyButtonStyles.secondaryButton,
              child: const Text('Cancelar descarga', style: TextStyle(fontSize: 16))
            ),
          ),
          const SizedBox(
            width: Constants.padding,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, MapatonMapPage.routeName),
              style: MyButtonStyles.primaryButton,
              child: const Text('Continuar', style: TextStyle(fontSize: 18))
            ),
          ),
        ],
      ),
    );
  }
}