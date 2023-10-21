import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyPrimaryElevatedButton extends StatelessWidget {
  final String label;
  final bool? fullWidth;
  final Function()? onPressed;

  const MyPrimaryElevatedButton({super.key, required this.label, this.fullWidth = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: fullWidth == true ? const Size.fromHeight(50) : null,
        backgroundColor: Constants.yellowButtonColor,
        disabledBackgroundColor: Constants.disabledButtonColor,
        shadowColor: Constants.yellowButtonShadowColor,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
        )
      ),
      child: Text(label, style: const TextStyle(color: Constants.darkBlueColor, fontSize: 18))
    );
  }
}