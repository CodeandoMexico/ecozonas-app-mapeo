import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../theme/theme.dart';
import '../widgets/app_button.dart';
import '../widgets/my_modal_bottom_sheet.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: AppSpacing.lg),
            Text('${AppLocalizations.of(context)!.pleaseWait}...'),
          ],
        ),
      );
    },
  );
}

void showConfirmationDialog(BuildContext context, {
  String? title,
  required String text,
  required String acceptButtonText,
  required VoidCallback acceptCallback
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: AppButton.outline(
                      label: AppLocalizations.of(context)!.no,
                      onPressed: () => Navigator.of(context).pop(),
                      fullWidth: true,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppButton.primary(
                      label: acceptButtonText,
                      onPressed: () {
                        Navigator.of(context).pop();
                        acceptCallback();
                      },
                      fullWidth: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  );
}

void showMyBottomSheet({
  required BuildContext context,
  String? titleText,
  required List<String> options,
  required Function(String) callback,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) {
      return MyModalBottomSheet(
        titleText: titleText,
        options: options,
        callback: callback,
      );
    },
  );
}
