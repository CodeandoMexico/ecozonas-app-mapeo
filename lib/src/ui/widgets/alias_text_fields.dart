import 'package:material_ui/material_ui.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../theme/theme.dart';

class AliasTextFields extends StatelessWidget {
  final int id;
  final TextEditingController aliasController;
  final Function(String)? callback;

  const AliasTextFields({super.key, required this.id, required this.aliasController, this.callback});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: aliasController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.writeYourName,
        prefixIcon: const Icon(Icons.edit_outlined),
        // El ID siempre visible (suffixText solo se ve con foco o con texto).
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: Text('#$id', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.textSecondary)),
        ),
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      ),
      onChanged: (value) {
        if (callback != null) {
          callback!(value);
        }
      },
    );
  }
}
