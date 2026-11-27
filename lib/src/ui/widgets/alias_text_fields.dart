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
        suffixText: '#$id',
        suffixStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.textSecondary),
      ),
      onChanged: (value) {
        if (callback != null) {
          callback!(value);
        }
      },
    );
  }
}
