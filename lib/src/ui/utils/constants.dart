import 'package:flutter/material.dart';

class ItemModel {
  ItemModel({
    required this.label,
    required this.value,
  });

  String label;
  String value;
}

class Constants {
  /*
   * MAP
   */
  /// Estilo del mapa (OpenFreeMap: mapas de OpenStreetMap, gratis y sin token).
  /// También se usa para descargar regiones sin conexión.
  static const mapStyleUrl = 'https://tiles.openfreemap.org/styles/liberty';

  /*
   * PADDING
   */
  static const paddingHuge = 80.0;
  static const paddingXLarge = 48.0;
  static const paddingLarge = 24.0;
  static const padding = 16.0;
  static const paddingMedium = 12.0;
  static const paddingSmall = 8.0;
  static const paddingMicro = 4.0;

  /*
   * RADIUS
   */
  static const borderRadiusSmall = 8.0;
  static const borderRadiusLarge = 40.0;
  static const borderRadius = 20.0;
  static const borderRadiusMedium = 12.0;
  static const borderRadiusBottomSheet = 24.0;

  /*
   * FONT SIZE
   */
  static const appBarFontSize = 18.0;

  /*
   * COLORS
   */
  static const disabledButtonColor = Color(0xFFDDDDDD);
  static const yellowButtonColor = Color(0xFFF9D47C);
  static const yellowButtonShadowColor = Color(0xFFB38254);
  static const blueButtonShadowColor = Color(0xFF1B1E2A);
  static const darkBlueColor = Color(0xFF4B5375);
  static const labelTextColor = Color(0xFF1F1F1F);
  static const whiteLabelTextColor = Color(0xFFFCFBF9);
  static const redColor = Color(0xFFDC362E);
}