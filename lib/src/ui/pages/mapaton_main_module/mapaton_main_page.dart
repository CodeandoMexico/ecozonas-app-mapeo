import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_navigation_bar_bloc.dart';
import 'mapaton_main_content.dart';

class MapatonMainPage extends StatelessWidget {
  static const routeName = 'mapatonMain';

  const MapatonMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBarBloc(),
      child: const MapatonMainContent(),
    );
  }
}