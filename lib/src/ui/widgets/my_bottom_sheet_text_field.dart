import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/constants.dart';
import '../utils/dialogs.dart' as dialogs;

class MyBottomSheetTextField extends StatelessWidget {
  final String titleText;
  final List<String> options;
  final Function(String) callback;

  MyBottomSheetTextField({super.key, required this.titleText, required this.options, required this.callback});

  final textController = TextEditingController();
  final style = const TextStyle(fontSize: 18, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onTap: () => showMyBottomSheet(context),
      readOnly: true,
      canRequestFocus: false,
      style: style,
      decoration: InputDecoration(
        label: Text(titleText, style: style),
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
        enabledBorder: _border(),
        focusedBorder: _border(),
        disabledBorder: _border(),
      ),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: BorderSide(color: myTheme.colorScheme.secondary),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    dialogs.showMyBottomSheet(
      context: context,
      titleText: titleText,
      options: options,
      callback: (value) {
        textController.text = value;
        callback(value);
      }
    );
  }
}