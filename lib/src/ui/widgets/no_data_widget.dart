import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: Text(
            'Aún no hay datos. Por favor, descargue los mapeos y encuestas presionando el botón superior.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}