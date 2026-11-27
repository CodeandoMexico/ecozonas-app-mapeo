import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../domain/models/db/mapaton_db_model.dart';
import '../../widgets/my_app_bar.dart';
import '../../utils/utils.dart' as utils;
import '../../utils/dialogs.dart' as dialogs;
import 'bloc/bloc.dart';
import '../../theme/theme.dart';
import '../../widgets/app_button.dart';

class UpdateMapContent extends StatelessWidget {
  static String routeName = 'updateMap';

  const UpdateMapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateMapBloc>();

    return Scaffold(
      appBar: MyAppBar(
        title: Text(AppLocalizations.of(context)!.sendData),
      ),
      body: _body(context, bloc),
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
          utils.showSnackBarError(context, AppLocalizations.of(context)!.sendError);
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

          return Padding(
            padding: AppSpacing.pageWithVertical,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.secondary),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!.objectCount(count),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton.primary(
                      onPressed: count != 0 ? () => _postMapaton(context, mapaton) : null,
                      label: AppLocalizations.of(context)!.sendMappings,
                      icon: Icons.upload,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
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