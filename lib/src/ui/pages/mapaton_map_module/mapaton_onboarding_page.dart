import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../domain/models/mapaton_model.dart';
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
        label: AppLocalizations.of(context)!.goToTools,
        fullWidth: true,
        onPressed: () => _continue(context, mapaton)
      ),
    );
  }

  /*
   * METHODS
   */
  Future<void> _continue(BuildContext context, MapatonModel mapaton) async {
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