/*
 * SNACKBARS
 */
import 'package:flutter/material.dart';

import 'constants.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Constants.yellowColor,
    ));
}