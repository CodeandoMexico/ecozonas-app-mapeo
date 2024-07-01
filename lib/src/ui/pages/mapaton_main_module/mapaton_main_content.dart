import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_navigation_bar_bloc.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';

class MapatonMainContent extends StatelessWidget {
  const MapatonMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
          builder: (context, state) => state as Widget,
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}