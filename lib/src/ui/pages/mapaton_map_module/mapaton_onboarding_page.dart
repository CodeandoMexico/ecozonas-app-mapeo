import 'package:flutter/material.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../data/repositories/db/mapaton/mapaton_repository_impl.dart';
import '../../../domain/models/db/mapaton_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/use_cases/db/mapaton_use_case.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/mapaton_carousel_widget.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../mapaton_main_module/mapaton_main_page.dart';

class MapatonOnboardingPage extends StatelessWidget {
  static const routeName = 'mapatonDetails';

  const MapatonOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as MapatonModel;

    return Scaffold(
      appBar: _appBar(mapaton),
      body: Column(
        children: [
          MapatonCarouselWidget(mapaton: mapaton),
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
  AppBar _appBar(MapatonModel mapaton) {
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
  Widget _buttons(BuildContext context, MapatonModel mapaton) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyPrimaryElevatedButton(
        label: 'Empezar mapeo',
        fullWidth: true,
        onPressed: () => _continue(context, mapaton)
      ),
    );
  }

  /*
   * METHODS
   */
  Future<void> _continue(BuildContext context, MapatonModel mapaton) async {
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
      final prefs = UserPreferences();
      final userId = prefs.getMapper!.id;
      final ids = prefs.getOnboardingTextShownIds;
      if (ids != null) {
        final list = ids.split(',');
        list.add(userId.toString());
        prefs.setOnboardingTextShownIds = list.join(',');
      } else {
        final l = [];
        l.add(userId);
        prefs.setOnboardingTextShownIds = l.join(',');
      }
      
      Navigator.pushNamed(context, MapatonMainPage.routeName);
    }
  }
}