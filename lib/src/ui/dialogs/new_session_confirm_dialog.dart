import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';
import '../widgets/my_primary_elevated_button.dart';
import '../widgets/my_secondary_elevated_button.dart';

class NewSessionConfirmDialog extends StatelessWidget {
  final String gender;
  final String age;
  final String disability;
  final Function callback;

  const NewSessionConfirmDialog({super.key, required this.gender, required this.age, required this.disability, required this.callback});

  @override
  Widget build(BuildContext context) {
    const styleBold = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const styleTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const styleField = TextStyle(fontSize: 14);

    return AlertDialog(
      backgroundColor: Colors.white,
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
            Text(AppLocalizations.of(context)!.detailsCorrect, style: styleTitle),
            const SizedBox(height: Constants.padding),
            Text(AppLocalizations.of(context)!.gender, style: styleField),
            Text(gender, style: styleBold),
            const SizedBox(height: Constants.padding),
            Text(AppLocalizations.of(context)!.ageRange, style: styleField),
            Text(age, style: styleBold),
            const SizedBox(height: Constants.padding),
            Text(AppLocalizations.of(context)!.disability, style: styleField),
            Text(disability, style: styleBold),
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
              label: AppLocalizations.of(context)!.no,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: MyPrimaryElevatedButton(
              onPressed: () {
                callback();
              },
              fullWidth: true,
              label: AppLocalizations.of(context)!.yes,
            ),
          ),
        ],
      ),
    );
  }
}