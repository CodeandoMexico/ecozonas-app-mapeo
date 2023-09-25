import 'package:flutter/material.dart';

class ActivityModel {
  ActivityModel({
    required this.title,
    required this.detail,
    required this.percentage,
    required this.type,
    required this.iconData,
    required this.backgroundColor,
    required this.borderColor,
  });

  String title;
  String detail;
  double percentage;
  String type;
  IconData iconData;
  Color backgroundColor;
  Color borderColor;
}