import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/db/mapaton_db_model.dart';
import '../../utils/constants.dart';
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
      appBar: MyAppBar(
        title: Text(AppLocalizations.of(context)!.sendData, style: const TextStyle(fontSize: Constants.appBarFontSize)),
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
          utils.showSnackBarSuccess(context, AppLocalizations.of(context)!.itemsSent);
          BlocProvider.of<UpdateMapBloc>(context).add(GetMapatonById());
        }
        if (state is ErrorSendingMapaton) {
          utils.showSnackBarError(context, state.error ?? AppLocalizations.of(context)!.errorFound);
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
          final s = count != 1 ? 's' : '';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.objectCount(count.toString(), s)),
                const SizedBox(height: 8.0),
                MyPrimaryElevatedButton(
                  onPressed: count != 0 ? () => _postMapaton(context, mapaton) : null,
                  label: AppLocalizations.of(context)!.sendMappings,
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
      text: AppLocalizations.of(context)!.sendMappingsNow,
      acceptButtonText: AppLocalizations.of(context)!.send,
      acceptCallback: () {
        BlocProvider.of<UpdateMapBloc>(context).add(SendMapaton(mapaton));
      }
    );
  }
}