import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/my_modal_bottom_sheet.dart';
import '../widgets/my_primary_elevated_button.dart';
import 'constants.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(width: 25),
            Text('Por favor espere...')
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
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: myTheme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12)
              )
            ),
            child: const Text('No', style: TextStyle(color: Constants.labelTextColor, fontSize: 18)),
          ),
          MyPrimaryElevatedButton(
            label: acceptButtonText,
            onPressed: () {
              Navigator.of(context).pop();
              acceptCallback();
            },
          ),
        ],
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