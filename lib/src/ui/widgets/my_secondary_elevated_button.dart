import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MySecondaryElevatedButton extends StatelessWidget {
  final String label;
  final IconData? iconData;
  final bool? fullWidth;
  final Function()? onPressed;

  const MySecondaryElevatedButton({super.key, required this.label, this.iconData, this.fullWidth = true, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Constants.darkBlueColor, fontSize: 18);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: fullWidth == true ? const Size.fromHeight(50) : null,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium)),
          side: BorderSide(color: Colors.black)
        )
      ),
      child: iconData == null ?
        Text(label, style: style) :
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: style),
            const SizedBox(width: Constants.paddingSmall),
            Icon(iconData)
          ],
      )
    );
  }
}