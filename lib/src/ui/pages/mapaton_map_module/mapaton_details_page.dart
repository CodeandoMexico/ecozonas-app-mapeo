import 'package:flutter/material.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../domain/models/db/mapaton_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/my_double_button_row.dart';
import '../mapaton_main_module/mapaton_main_page.dart';

class MapatonDetailsPage extends StatelessWidget {
  static const routeName = 'mapatonDetails';

  const MapatonDetailsPage({super.key});

  // final details = [
  //   'Infraestructura',
  //   'Accesibilidad y planificación urbana',
  //   'Calidad de las vías',
  //   'Disponibilidad de espacios verdes',
  //   'Distribución de servicios públicos',
  //   'Conectividad',
  // ];

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as Mapaton;

    return Scaffold(
      appBar: _appBar(mapaton),
      body: Column(
        children: [
          _header(context),
          const SizedBox(height: Constants.paddingXLarge),
          _sectionTitle(mapaton),
          const SizedBox(height: Constants.paddingXLarge),
          _details(mapaton),
          const Spacer(),
          _buttons(context, mapaton)
        ],
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  /*
   * APP BAR
   */
  AppBar _appBar(Mapaton mapaton) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.map),
          const SizedBox(width: Constants.paddingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mapaton.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(mapaton.locationText, style: const TextStyle(fontSize: 14)),
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

  Text _sectionTitle(Mapaton mapaton) {
    return Text(
      mapaton.categories[0].name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Color(0xFF29496E))
    );
  }

  Widget _details(Mapaton mapaton) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Text(
        mapaton.categories[0].description,
        style: const TextStyle(fontSize: 16)
      ),
    );
    // return Container(
    //   width: double.infinity,
    //   margin: const EdgeInsets.symmetric(horizontal: Constants.padding),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: details.map((e) {
    //       return Padding(
    //         padding: const EdgeInsets.all(6.0),
    //         child: Text('\u2022 \t $e', style: const TextStyle(fontSize: 16)),
    //       );
    //     }).toList(),
    //   ),
    // );
  }

  Widget _buttons(BuildContext context, Mapaton mapaton) {
    return Container(
      margin: const EdgeInsets.all(Constants.padding),
      child: MyDoubleButtonRow(
        cancelText: 'Cancelar descarga',
        cancelCallback: () => Navigator.pop(context),
        acceptText: 'Continuar',
        acceptCallback: () => _continue(context, mapaton),
      ),
    );
  }

  /*
   * METHODS
   */
  Future<void> _continue(BuildContext context, Mapaton mapaton) async {
    final prefs = UserPreferences();
    final mapper = prefs.getMapper;

    final useCase = MapatonUseCase(MapatonRepositoryImpl());
    final m = await useCase.getMapatonsByUuidAndMapper(mapaton.uuid, mapper!.id.toString());
    
    if (m == null) {
      final id = await useCase.addMapaton(MapatonDbModel(
        uuid: mapaton.uuid,
        dateTime: DateTime.now(),
        mapperId: mapper.id,
        mapperGender: mapper.sociodemographicData.genre,
        mapperAge: mapper.sociodemographicData.ageRange,
        mapperDisability: mapper.sociodemographicData.disability,
      ));
      prefs.setMapatonDbId = id;
    } else {
      prefs.setMapatonDbId = m.id;
    }
    
    if (context.mounted) {
      Navigator.pushNamed(context, MapatonMainPage.routeName, arguments: mapaton);
    }
  }
}