import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_navigation_bar_bloc.dart';
import 'bloc/bloc.dart';
import 'mapaton_map_content.dart';

class MapatonMapPage extends StatelessWidget implements BottomNavigationBarState {
  static String routeName = 'mapatonMap';
  
  const MapatonMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapatonBloc bloc = context.read<MapatonBloc>();
    if (!bloc.isClosed) {
      bloc = MapatonBloc();
    }
    
    return BlocProvider(
      create: (context) => bloc,
      child: const MapatonMapContent(),
    );
  }
}