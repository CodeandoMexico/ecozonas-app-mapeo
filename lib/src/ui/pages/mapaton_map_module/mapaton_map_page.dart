import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/mapaton_model.dart';
import '../../bloc/bottom_navigation_bar_bloc.dart';
import 'bloc/bloc.dart';
import 'mapaton_map_content.dart';

class MapatonMapPage extends StatelessWidget implements BottomNavigationBarState {
  static String routeName = 'mapatonMap';
  
  const MapatonMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as Mapaton;
    
    return BlocProvider(
      create: (context) => MapatonBloc()..add(GetLocation())..add(GetMarkers(mapaton.uuid)),
      child: MapatonMapContent(),
    );
  }
}