import 'package:flutter/material.dart';

import '../../styles/my_button_styles.dart';
import '../../widgets/my_app_bar.dart';

class ViewMapPage extends StatelessWidget {
  static String routeName = 'viewMap';

  const ViewMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Column(
          children: [
            Text('Biciestacionamiento', style: TextStyle(fontSize: 14)),
            Text('(Hospital San Gabriel)', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: Stack(
        children: [
          _map(),
          _button(context)
        ],
      ),
    );
  }

  Widget _map() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/map_placeholder.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: MyButtonStyles.secondaryButton,
          child: const Text('Regresar al mapeo', style: TextStyle(color: Colors.white))
        ),
      ),
    );
  }
}