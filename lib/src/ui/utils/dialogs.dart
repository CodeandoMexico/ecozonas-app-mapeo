import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/theme.dart';
import '../widgets/my_modal_bottom_sheet.dart';
import '../widgets/my_primary_elevated_button.dart';
import 'constants.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.only(top: Constants.paddingSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.black,
              ),
              const SizedBox(width: 25),
              Text('${AppLocalizations.of(context)!.pleaseWait}...')
            ],
          ),
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
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Wrap(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48.0),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: myTheme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    child: Text(AppLocalizations.of(context)!.no, style: const TextStyle(color: Constants.labelTextColor, fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                  MyPrimaryElevatedButton(
                    label: acceptButtonText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      acceptCallback();
                    },
                  ),
                  const Spacer(),
                ],
              )
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Constants.borderRadiusBottomSheet),
        topRight: Radius.circular(Constants.borderRadiusBottomSheet),
      )
    ),
    builder: (_) {
      return MyModalBottomSheet(
        titleText: titleText,
        options: options,
        callback: callback,
      );
    },
  );
}