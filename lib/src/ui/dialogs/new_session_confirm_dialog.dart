import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../theme/theme.dart';
import '../widgets/app_button.dart';

class NewSessionConfirmDialog extends StatelessWidget {
  final String gender;
  final String age;
  final String disability;
  final Function callback;

  const NewSessionConfirmDialog({super.key, required this.gender, required this.age, required this.disability, required this.callback});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    Widget field(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Column(
          children: [
            Text(label, style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.xxs),
            Text(value, style: textTheme.titleSmall, textAlign: TextAlign.center),
          ],
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.detailsCorrect, style: textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            field(l10n.gender, gender),
            field(l10n.ageRange, age),
            field(l10n.disability, disability),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppButton.outline(label: l10n.no, onPressed: () => Navigator.pop(context), fullWidth: true),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton.primary(label: l10n.yes, onPressed: () => callback(), fullWidth: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
