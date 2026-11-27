import 'package:material_ui/material_ui.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../bloc/bottom_navigation_bar_bloc.dart';
import '../theme/theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Colores y tipografía vienen del tema (bottomNavigationBarTheme).
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.map_outlined),
              activeIcon: const Icon(Icons.map),
              label: AppLocalizations.of(context)!.tools),
          BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              activeIcon: const Icon(Icons.account_circle),
              label: AppLocalizations.of(context)!.mySession),
          BottomNavigationBarItem(
              icon: const Icon(Icons.info_outline),
              activeIcon: const Icon(Icons.info),
              label: AppLocalizations.of(context)!.aboutEcozonas),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          BlocProvider.of<BottomNavigationBarBloc>(context)
              .add(BottomNavigationBarEvents.values[value]);
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
