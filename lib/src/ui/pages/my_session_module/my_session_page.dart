import 'package:flutter/material.dart';

import '../../bloc/bottom_navigation_bar_bloc.dart';
import '../../utils/constants.dart';
import '../../widgets/my_app_bar.dart';

class MySessionPage extends StatelessWidget implements BottomNavigationBarState {
  const MySessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Mi sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            _logoutButton(context)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /*
   * METHODS
   */
  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Constants.redColor)
        )
      ),
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Text(
        'Salir de la sesión',
        style: TextStyle(
          color: Constants.redColor,
          fontWeight: FontWeight.w500,
          fontSize: 18
        )
      )
    );
  }
}