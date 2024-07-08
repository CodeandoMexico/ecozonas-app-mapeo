import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/mapaton_model.dart';
import 'bloc/bloc.dart';
import 'mapaton_map_content.dart';

class MapatonMapPage extends StatelessWidget {
  static String routeName = 'mapatonMap';

  final MapatonModel? mapaton;
  
  const MapatonMapPage({super.key, this.mapaton});

  @override
  Widget build(BuildContext context) {
    MapatonBloc bloc = context.read<MapatonBloc>();
    if (!bloc.isClosed) {
      bloc = MapatonBloc();
    }
    
    return BlocProvider(
      create: (context) => bloc,
      child: MapatonMapContent(mapaton: mapaton),
    );
  }
}