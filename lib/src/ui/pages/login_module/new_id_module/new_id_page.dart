import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/new_id_bloc.dart';
import 'new_id_content.dart';

class NewIdPage extends StatelessWidget {
  static const routeName = 'newId';

  final Function? callback;

  const NewIdPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NewIdBloc(),
        child: const NewIdContent(),
      ),
    );
  }
}