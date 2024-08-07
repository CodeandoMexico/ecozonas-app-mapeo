import 'package:flutter/material.dart';

import '../styles/my_button_styles.dart';
import '../utils/constants.dart';

class MyDoubleButtonRow extends StatelessWidget {
  final String cancelText;
  final Function cancelCallback;
  final String acceptText;
  final Function acceptCallback;

  const MyDoubleButtonRow({super.key, required this.cancelText, required this.cancelCallback, required this.acceptText, required this.acceptCallback});

  final _style = const TextStyle(fontSize: 16, color: Constants.darkBlueColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => cancelCallback(),
            style: MyButtonStyles.cancelButton,
            child: Text(cancelText, style: _style)
          ),
        ),
        const SizedBox(
          width: Constants.padding,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => acceptCallback(),
            style: MyButtonStyles.primaryButton,
            child: Text(acceptText, style: _style)
          ),
        ),
      ],
    );
  }
}