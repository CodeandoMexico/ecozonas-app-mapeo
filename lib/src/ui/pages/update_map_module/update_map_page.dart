import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'update_map_content.dart';

class UpdateMapPage extends StatelessWidget {
  static String routeName = 'updateMap';
  
  const UpdateMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateMapBloc()..add(GetMapatonById()),
      child: const UpdateMapContent(),
    );
  }
}