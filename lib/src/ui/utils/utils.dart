import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../domain/models/sociodemographic_codes.dart';
import 'constants.dart';
import '../theme/theme.dart';

/*
 * SNACKBARS
 */
void showSnackBar(BuildContext context, String message) {
  _showAppSnackBar(context, message, icon: Icons.info_outline, iconColor: AppColors.primary, background: AppColors.textPrimary);
}

void showSnackBarSuccess(BuildContext context, String message) {
  _showAppSnackBar(context, message, icon: Icons.check_circle_outline, iconColor: AppColors.primary, background: AppColors.textPrimary);
}

void showSnackBarError(BuildContext context, String message) {
  _showAppSnackBar(context, message, icon: Icons.error_outline, iconColor: Colors.white, background: AppColors.error);
}

void _showAppSnackBar(BuildContext context, String message, {required IconData icon, required Color iconColor, required Color background}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: background,
      content: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
          ),
        ],
      ),
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
    case 'CALIDAD_AMBIENTAL':
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

List<ItemModel> getLanguageOptions(BuildContext context) {
  return [
    ItemModel(label: AppLocalizations.of(context)!.spanish, value: 'es'),
    ItemModel(label: AppLocalizations.of(context)!.english, value: 'en'),
  ];
}

List<ItemModel> getGenderOptions(BuildContext context) {
  return [
    ItemModel(label: AppLocalizations.of(context)!.woman, value: 'MUJER'),
    ItemModel(label: AppLocalizations.of(context)!.man, value: 'HOMBRE'),
    ItemModel(label: AppLocalizations.of(context)!.nonbinary, value: 'NO_BINARIO'),
    ItemModel(label: AppLocalizations.of(context)!.other, value: 'OTRO'),
    ItemModel(label: AppLocalizations.of(context)!.preferNoAnswer, value: 'NO_CONTESTO'),
  ];
}

List<ItemModel> getAgeRange(BuildContext context) {
  return [
    ItemModel(label: AppLocalizations.of(context)!.less18, value: 'MENOS_18'),
    ItemModel(label: AppLocalizations.of(context)!.between18, value: '18_25'),
    ItemModel(label: AppLocalizations.of(context)!.between26, value: '26_35'),
    ItemModel(label: AppLocalizations.of(context)!.between36, value: '36_45'),
    ItemModel(label: AppLocalizations.of(context)!.between46, value: '46_55'),
    ItemModel(label: AppLocalizations.of(context)!.between56, value: '56_65'),
    ItemModel(label: AppLocalizations.of(context)!.more65, value: 'MAS_65'),
    ItemModel(label: AppLocalizations.of(context)!.preferNoAnswer, value: 'NO_CONTESTO'),
  ];
}

List<ItemModel> getDisiability(BuildContext context) {
  return [
    ItemModel(label: AppLocalizations.of(context)!.none, value: 'NINGUNA'),
    ItemModel(label: AppLocalizations.of(context)!.motor, value: 'MOTRIZ'),
    ItemModel(label: AppLocalizations.of(context)!.visual, value: 'VISUAL'),
    ItemModel(label: AppLocalizations.of(context)!.hearing, value: 'AUDITIVA'),
    ItemModel(label: AppLocalizations.of(context)!.cognitive, value: 'COGNITIVA'),
    ItemModel(label: AppLocalizations.of(context)!.other2, value: 'OTRA'),
    ItemModel(label: AppLocalizations.of(context)!.preferNoAnswer, value: SociodemographicCodes.noAnswer),
  ];
}

/// Etiqueta de la opción cuyo código es [value]; si no existe, el código.
String optionLabel(List<ItemModel> options, String value) {
  for (final option in options) {
    if (option.value == value) return option.label;
  }
  return value;
}

/// Texto del contenido que manda el servidor (mapatones, actividades,
/// opciones) en el idioma de la app. El servidor manda español y, cuando
/// existe, inglés; si falta la traducción se muestra el español.
String localized(BuildContext context, {required String es, String? en}) {
  final languageCode = Localizations.localeOf(context).languageCode;
  if (languageCode == 'en' && en != null && en.isNotEmpty) return en;
  return es;
}
