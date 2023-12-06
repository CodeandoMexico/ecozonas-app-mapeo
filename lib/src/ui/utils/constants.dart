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
   * LISTS
   */
  static List<ItemModel> gender = [
    ItemModel(label: 'Mujer', value: 'MUJER'),
    ItemModel(label: 'Hombre', value: 'HOMBRE'),
    ItemModel(label: 'No binario', value: 'NO_BINARIO'),
    ItemModel(label: 'Otro', value: 'OTRO'),
    ItemModel(label: 'Prefiero no contestar', value: 'NO_CONTESTO'),
  ];

  static List<ItemModel> ageRange = [
    ItemModel(label: 'Menos de 18 años', value: 'MENOS_18'),
    ItemModel(label: 'Entre 18 y 25 años', value: '18_25'),
    ItemModel(label: 'Entre 26 y 35 años', value: '26_35'),
    ItemModel(label: 'Entre 36 y 45 años', value: '36_45'),
    ItemModel(label: 'Entre 46 y 55 años', value: '46_55'),
    ItemModel(label: 'Entre 56 y 65 años', value: '56_65'),
    ItemModel(label: 'Más de 65 años', value: 'MAS_65'),
  ];

  static List<ItemModel> disability = [
    ItemModel(label: 'Ninguna', value: 'NINGUNA'),
    ItemModel(label: 'Motriz', value: 'MOTRIZ'),
    ItemModel(label: 'Visual', value: 'VISUAL'),
    ItemModel(label: 'Auditiva', value: 'AUDITIVA'),
    ItemModel(label: 'Cognitiva', value: 'COGNITIVA'),
    ItemModel(label: 'Otra', value: 'OTRA'),
  ];

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