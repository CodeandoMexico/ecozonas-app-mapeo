import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_navigation_bar_bloc.dart';
import 'bloc/bloc.dart';
import 'my_session_content.dart';

class MySessionPage extends StatelessWidget implements BottomNavigationBarState {
  final Function? callback;

  const MySessionPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MySessionBloc()..add(GetMapper()),
        child: MySessionContent(),
      ),
    );
  }
}