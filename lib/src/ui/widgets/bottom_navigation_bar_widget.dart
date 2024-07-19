import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: AppLocalizations.of(context)!.tools
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          label: AppLocalizations.of(context)!.mySession
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info_outline),
          label: AppLocalizations.of(context)!.aboutEcozonas
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