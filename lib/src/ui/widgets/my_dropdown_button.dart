import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/constants.dart';

class MyDropdownButton extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final Function(String?) onChange;

  const MyDropdownButton({super.key, required this.labelText, required this.items, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: _getItems(),
      style: const TextStyle(fontSize: 18, color: Constants.labelTextColor),
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: _border(),
        focusedBorder: _border()
      ),
      onChanged: (value) => onChange(value)
    );
  }

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> list = [];

    for (var element in items) {
      list.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    }

    return list;
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: BorderSide(color: myTheme.colorScheme.secondary),
    );
  }
}