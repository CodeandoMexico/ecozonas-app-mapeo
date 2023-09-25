import 'package:flutter/material.dart';

import '../pages/login_module/new_session_module/new_id_page.dart';
import '../utils/constants.dart';
import '../widgets/my_primary_elevated_button.dart';
import '../widgets/my_secondary_elevated_button.dart';

class NewSessionConfirmDialog extends StatelessWidget {
  const NewSessionConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const styleBold = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const styleTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const styleField = TextStyle(fontSize: 14);

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding)
      ),
      content: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            const Text('¿Tus datos son correctos?', style: styleTitle),
            const SizedBox(height: Constants.padding),
            const Text('Género', style: styleField),
            const Text('Mujer', style: styleBold),
            const SizedBox(height: Constants.padding),
            const Text('Rango de edad', style: styleField),
            const Text('56-65 años', style: styleBold),
            const SizedBox(height: Constants.padding),
            const Text('Discapacidad', style: styleField),
            const Text('Motriz', style: styleBold),
            const SizedBox(height: Constants.padding),
            _buttons(context)
          ],
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: MySecondaryElevatedButton(
              onPressed: () => Navigator.pop(context),
              fullWidth: false,
              label: 'No',
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: MyPrimaryElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, NewIdPage.routeName);
              },
              fullWidth: false,
              label: 'Si',
            ),
          ),
        ],
      ),
    );
  }
}