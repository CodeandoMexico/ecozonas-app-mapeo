import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'continue_session_content.dart';

class ContinueSessionPage extends StatelessWidget {
  const ContinueSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ContinueSessionBloc()..add(GetSessions()),
        child: const ContinueSessionContent(),
      ),
      backgroundColor: Colors.white,
    );
  }
}