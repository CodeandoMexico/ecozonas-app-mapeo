import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/db/mapaton_db_model.dart';
import '../../widgets/my_app_bar.dart';
import '../../utils/utils.dart' as utils;
import '../../utils/dialogs.dart' as dialogs;
import '../../widgets/my_primary_elevated_button.dart';
import 'bloc/bloc.dart';

class UpdateMapContent extends StatelessWidget {
  static String routeName = 'updateMap';

  const UpdateMapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateMapBloc>();

    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Sincronizar datos'),
      ),
      body: _body(context, bloc),
      backgroundColor: Colors.white,
    );
  }

  /*
   * WIDGETS
   */
  Widget _body(BuildContext context, UpdateMapBloc bloc) {
    return BlocListener<UpdateMapBloc, UpdateMapState>(
      listener: (context, state) {
        if (state is GettingMapatons || state is SendingMapaton) {
          dialogs.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
        if (state is MapatonSent) {
          utils.showSnackBarSuccess(context, 'Los objetos fueron enviados correctamente');
        }
      },
      child: _sendButton(context, bloc),
    );
  }

  Widget _sendButton(BuildContext context, UpdateMapBloc bloc) {
    return StreamBuilder<MapatonDbModel?>(
      stream: bloc.mapaton,
      builder: (BuildContext context, AsyncSnapshot<MapatonDbModel?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final mapaton = snapshot.data!;
          final count = mapaton.activities != null ? mapaton.activities!.length : 0;
          final s = count > 1 ? 's' : '';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Text('Hay $count objeto$s mapeado$s por enviar'),
                const SizedBox(height: 8.0),
                MyPrimaryElevatedButton(
                  onPressed: () => _postMapaton(context, mapaton),
                  label: 'Enviar mapeos',
                  fullWidth: true,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*
   * METHODS
   */
  Future<void> _postMapaton(BuildContext context, MapatonDbModel mapaton) async {
    dialogs.showConfirmationDialog(
      context,
      title: '¿Enviar los objetos ahora?',
      text: 'Al enviar los objetos ya no serán visibles en el mapa.',
      acceptButtonText: 'Enviar',
      acceptCallback: () {
        BlocProvider.of<UpdateMapBloc>(context).add(SendMapaton(mapaton));
      }
    );
  }
}