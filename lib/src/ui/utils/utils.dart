import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

/*
 * SNACKBARS
 */
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Constants.labelTextColor)),
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

void showSnackBarError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    backgroundColor: Constants.redColor
  ));
}

/*
 * DATES
 */
String formatDate(DateTime dateTime, {String strFormat = 'dd/MM/yyyy HH:mm'}) {
  final format = DateFormat(strFormat);
  return format.format(dateTime);
}

/*
 * ICONS
 */
Widget getCategoryIcon({required String code, required int size, Color color = Colors.black}) {
  String image = 'assets/icons/ic_building_solid.svg';

  switch(code) {
    case 'ENTORNO_URBANO':
      image = 'assets/icons/ic_building_solid.svg';
    case 'CALIDAD_MEDIOAMBIENTAL':
      image = 'assets/icons/ic_leaf_solid.svg';
    case 'BIENESTAR_SOCIOECONOMICO':
      image = 'assets/icons/ic_people_roof_solid.svg';
    case 'RIESGO_DESASTRES':
      image = 'assets/icons/ic_volcano_solid.svg';
    case 'OTRA':
      image = 'assets/icons/ic_plus_solid.svg';
  }

  return SvgPicture.asset(
    image,
    height: size.toDouble(),
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}

String removeDiacritics(String str) {
  var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz'; 

  for (int i = 0; i < withDia.length; i++) {      
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
  return str.toLowerCase();
}