import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

/*
 * SNACKBARS
 */
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Constants.yellowButtonColor,
  ));
}

void showSnackBarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Constants.labelTextColor)),
    backgroundColor: Constants.yellowButtonColor
  ));
}

/*
 * DATES
 */
String formatDate(DateTime dateTime, {String strFormat = 'dd/MM/yyyy HH:mm'}) {
  final format = DateFormat(strFormat);
  return format.format(dateTime);
}