import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_navigation_bar_bloc.dart';

class BottomNavigationBarWidget extends StatefulWidget {  
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Mi sesión'
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (value) {
        BlocProvider.of<BottomNavigationBarBloc>(context).add(BottomNavigationBarEvents.values[value]);
        setState(() {
          _currentIndex = value;
        });
      },
    );
  }
}