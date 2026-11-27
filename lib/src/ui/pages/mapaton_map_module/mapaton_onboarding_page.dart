import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../theme/theme.dart';
import '../../widgets/mapaton_carousel_widget.dart';
import '../mapaton_main_module/mapaton_main_page.dart';
import '../../widgets/app_button.dart';

class MapatonOnboardingPage extends StatelessWidget {
  static const routeName = 'mapatonDetails';

  const MapatonOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as MapatonModel;

    return Scaffold(
      appBar: _appBar(mapaton),
      body: SingleChildScrollView( // Add scrollability
        child: Column(
          children: [
            MapatonCarouselWidget(mapaton: mapaton),
            _buttons(context, mapaton),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }

  /*
   * APP BAR
   */
  AppBar _appBar(MapatonModel mapaton) {
    return AppBar(
      title: Column(
        children: [
          Text(mapaton.title),
          if (mapaton.locationText.isNotEmpty)
            Text(mapaton.locationText, style: appTheme.textTheme.bodySmall),
        ],
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _buttons(BuildContext context, MapatonModel mapaton) {
    return Padding(
      padding: AppSpacing.pageWithVertical,
      child: AppButton.primary(
        label: AppLocalizations.of(context)!.goToTools,
        fullWidth: true,
        onPressed: () => _continue(context, mapaton),
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
