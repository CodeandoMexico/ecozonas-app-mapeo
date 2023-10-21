import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/new_session_bloc.dart';
import 'new_session_content.dart';

class NewSessionPage extends StatelessWidget {
  static const routeName = 'newSession';

  final Function? callback;

  const NewSessionPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NewSessionBloc(),
        child: NewSessionContent(
          callback: callback!,
        ),
      ),
    );
  }
}