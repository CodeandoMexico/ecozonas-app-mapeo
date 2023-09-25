import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/constants.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;

  const MyTextFormField({super.key, required this.controller, this.hintText, this.prefixIconData, this.suffixIconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
        suffixIcon: suffixIconData != null ? Icon(suffixIconData) : null,
        enabledBorder: _border(),
        focusedBorder: _border(),
      ),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadiusLarge),
      borderSide: BorderSide(color: myTheme.colorScheme.secondary),
    );
  }
}