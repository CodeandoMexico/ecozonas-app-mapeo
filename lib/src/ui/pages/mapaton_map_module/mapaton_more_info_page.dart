import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../widgets/ecozonas_image.dart';
import '../../widgets/my_app_bar.dart';
import '../../theme/theme.dart';
import '../../widgets/app_numbered_text.dart';

class MapatonMoreInfoPage extends StatelessWidget {
  static const routeName = 'moreInfo';

  const MapatonMoreInfoPage({super.key});


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MyAppBar(title: Text(l10n.webPlatform)),
      body: SingleChildScrollView(
        padding: AppSpacing.pageWithVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EcozonasImage(topPadding: AppSpacing.xs, bottomPadding: AppSpacing.lg),
            Text(l10n.moreInfoIntro, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.md),
            AppNumberedText(marker: '1.', text: l10n.moreInfo1),
            AppNumberedText(marker: '2.', text: l10n.moreInfo2),
            AppNumberedText(marker: '3.', text: l10n.moreInfo3),
            AppNumberedText(marker: '4.', text: l10n.moreInfo4),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.moreInfo5, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.lg),
            ClipRRect(borderRadius: AppRadius.mdAll, child: Image.asset('assets/images/more_info_chart.png')),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(borderRadius: AppRadius.mdAll, child: Image.asset('assets/images/more_info_map.png')),
          ],
        ),
      ),
    );
  }
}
