import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/my_app_bar.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import '../../../widgets/my_secondary_elevated_button.dart';
import '../../mapaton_module/mapaton_list_page.dart';
import '../../../utils/utils.dart' as utils;

class NewIdPage extends StatelessWidget {
  static const routeName = 'newId';

  const NewIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = '#1842';

    return Scaffold(
      appBar: const MyAppBar(
        title: 'ID de mapeo',
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          children: [
            const SizedBox(height: Constants.padding),
            const Text('Este es tu ID de mapeo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: Constants.paddingLarge),
            const Text('Anota tu ID en caso de necesitarlo más adelante', style: TextStyle(fontSize: 15)),
            const SizedBox(height: Constants.paddingLarge),
            _idTextField(controller),
            const SizedBox(height: Constants.paddingLarge),
            _copyButton(context, controller),
            const Spacer(),
            _continueButton(context),
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  Widget _idTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      readOnly: true,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: _border(),
        focusedBorder: _border(),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadiusSmall),
      borderSide: BorderSide(color: myTheme.colorScheme.secondary),
    );
  }

  Widget _copyButton(BuildContext context, TextEditingController controller) {
    return MySecondaryElevatedButton(
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: controller.text)).then((value) {
          utils.showSnackBar(context, 'ID copiado');
        });
      },
      label: 'Copiar',
      iconData: Icons.copy,
    );
  }

  Widget _continueButton(BuildContext context) {
    return MyPrimaryElevatedButton(
      onPressed: () => Navigator.pushNamed(context, MapatonListPage.routeName),
      label: 'Continuar',
    );
  }
}