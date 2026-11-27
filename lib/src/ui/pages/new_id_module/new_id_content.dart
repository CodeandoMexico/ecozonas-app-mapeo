import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../theme/theme.dart';
import '../../widgets/alias_text_fields.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../pages.dart';
import 'bloc/bloc.dart';

class NewIdContent extends StatelessWidget {
  const NewIdContent({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    final aliasController = TextEditingController();

    return Scaffold(
      appBar: MyAppBar(
        title: Text(AppLocalizations.of(context)!.mappingId),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pageWithVertical,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              AliasTextFields(id: id, aliasController: aliasController),
              const Spacer(),
              _continueButton(context, aliasController),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }

  Widget _continueButton(BuildContext context, TextEditingController aliasController) {
    return MyPrimaryElevatedButton(
      onPressed: () {
        BlocProvider.of<NewIdBloc>(context).add(AddAlias(aliasController.text));
        
        final prefs = UserPreferences();
        final userId = prefs.getMapper!.id;
        final ids = prefs.getOnboardingTextShownIds;
        if (ids != null) {
          final list = ids.split(',');
          if (list.contains(userId.toString())) {
            Navigator.pushReplacementNamed(context, MapatonTabsPage.routeName);
          } else {
            Navigator.pushNamed(context, MapatonTextOnboardingPage.routeName, arguments: true);
          }
        } else {
          Navigator.pushNamed(context, MapatonTextOnboardingPage.routeName, arguments: true);
        }
      },
      fullWidth: true,
      label: AppLocalizations.of(context)!.continueText,
    );
  }
}