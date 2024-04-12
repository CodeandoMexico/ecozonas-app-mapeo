import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../theme/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/alias_text_fields.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../../widgets/my_secondary_elevated_button.dart';
import '../../utils/utils.dart' as utils;
import '../pages.dart';
import 'bloc/bloc.dart';

class NewIdContent extends StatelessWidget {
  const NewIdContent({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    final aliasController = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(
        title: Text('ID de mapeo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          children: [
            const SizedBox(height: Constants.paddingXLarge),
            AliasTextFields(id: id, aliasController: aliasController),
            const Spacer(),
            _continueButton(context, aliasController),
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  Widget _copyButton(BuildContext context, int id) {
    return MySecondaryElevatedButton(
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: id.toString())).then((value) {
          utils.showSnackBar(context, 'ID copiado');
        });
      },
      label: 'Copiar',
      iconData: Icons.copy,
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
            Navigator.pushReplacementNamed(context, MapatonTextOnboardingPage.routeName, arguments: true);
          }
        } else {
          Navigator.pushReplacementNamed(context, MapatonTextOnboardingPage.routeName, arguments: true);
        }
      },
      fullWidth: true,
      label: 'Continuar',
    );
  }
}