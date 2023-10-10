import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyButtonStyles {
  static final primaryButton = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(50),
    backgroundColor: Constants.yellowColor,
    disabledBackgroundColor: Constants.disabledColor,
    shadowColor: Constants.yellowShadowColor,
    elevation: 5,
    textStyle: const TextStyle(fontSize: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
    )
  );

  static final secondaryButton = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(50),
    backgroundColor: Constants.blueColor,
    disabledBackgroundColor: Constants.disabledColor,
    shadowColor: Constants.blueShadowColor,
    elevation: 5,
    textStyle: const TextStyle(fontSize: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
    )
  );

  static final cancelButton = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(50),
    backgroundColor: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium)),
      side: BorderSide(color: Colors.black)
    )
  );
}