import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/my_app_bar.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import '../../../widgets/my_secondary_elevated_button.dart';
import '../../mapaton_list_module/mapaton_list_page.dart';
import '../../../utils/utils.dart' as utils;

class NewIdPage extends StatelessWidget {
  static const routeName = 'newId';

  const NewIdPage({super.key});

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
            const SizedBox(height: Constants.padding),
            const Text('Este es tu ID de mapeo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: Constants.paddingLarge),
            const Text('Anota tu ID en caso de necesitarlo más adelante', style: TextStyle(fontSize: 15)),
            const SizedBox(height: Constants.paddingLarge),
            _textFields(aliasController, id),
            const SizedBox(height: Constants.paddingLarge),
            _copyButton(context, id),
            const Spacer(),
            _continueButton(context),
          ],
        ),
      ),
      backgroundColor: myTheme.primaryColor,
    );
  }

  Widget _textFields(TextEditingController aliasController, int id) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: myTheme.colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(Constants.borderRadiusSmall)
      ),
      child: Row(
        children: [
          _aliasTextField(aliasController),
          _divider(),
          _idText(id),
        ],
      ),
    );
  }

  Widget _aliasTextField(TextEditingController aliasController) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: TextFormField(
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          controller: aliasController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(Icons.edit_outlined, color: Colors.black)
          ),
          cursorColor: Colors.black,
        ),
      )
    );
  }

  Widget _divider() {
    return Container(
      color: Constants.labelTextColor,
      width: 1,
      height: 30,
    );
  }

  Widget _idText(int id) {
    return Flexible(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '#$id',
          style: const TextStyle(fontSize: 20),
        ),
      ),
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

  Widget _continueButton(BuildContext context) {
    return MyPrimaryElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, MapatonListPage.routeName);
      },
      fullWidth: true,
      label: 'Continuar',
    );
  }
}