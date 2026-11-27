import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../theme/theme.dart';

class BlockErrorTextWidget extends StatelessWidget {
  final bool showError;

  const BlockErrorTextWidget({super.key, required this.showError});

  @override
  Widget build(BuildContext context) {
    if (!showError) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 16, color: AppColors.error),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            AppLocalizations.of(context)!.required,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.error),
          ),
        ],
      ),
    );
  }
}