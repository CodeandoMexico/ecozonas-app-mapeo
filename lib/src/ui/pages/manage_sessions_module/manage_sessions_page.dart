import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'manage_sessions_content.dart';

class ManageSessionsPage extends StatelessWidget {
  static const routeName = 'manageSessions';

  final Function? callback;

  const ManageSessionsPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ManageSessionsBloc()..add(GetSessions()),
        child: const ManageSessionsContent(),
      ),
    );
  }
}