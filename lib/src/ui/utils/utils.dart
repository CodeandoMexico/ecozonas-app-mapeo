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
    backgroundColor: Constants.yellowColor,
    ));
}

/*
 * DATES
 */
String formatDate(DateTime dateTime) {
  final format = DateFormat('dd/MM/yyyy HH:mm');
  return format.format(dateTime);
}