import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import 'ecozonas_image.dart';
import '../theme/theme.dart';
import 'app_button.dart';

class NoDataWidget extends StatelessWidget {
  final VoidCallback callback;

  const NoDataWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          const EcozonasImage(topPadding: AppSpacing.xxl, bottomPadding: AppSpacing.xl),
          Text(
            AppLocalizations.of(context)!.noDataYet,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton.primary(
            label: AppLocalizations.of(context)!.download,
            icon: Icons.download,
            onPressed: () => callback(),
          ),
        ],
      ),
    );
  }
}
