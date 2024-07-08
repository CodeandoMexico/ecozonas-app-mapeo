import 'package:flutter/material.dart';

class EcozonasImage extends StatelessWidget {
  final double topPadding;
  final double bottomPadding;

  const EcozonasImage({super.key, required this.topPadding, required this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, topPadding, 0, bottomPadding),
      child: Image.asset('assets/images/new_app_logo.png', height: 30),
    );
  }
}