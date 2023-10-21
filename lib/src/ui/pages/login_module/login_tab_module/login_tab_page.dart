import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'login_tab_content.dart';

class LoginTabPage extends StatelessWidget {
  static const String routeName = 'loginTabPage';

  const LoginTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginTabBloc()..add(GetSessions()),
        child: const LoginTabContent(),
      ),
    );
  }
}