import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../domain/models/db/mapper_db_model.dart';
import '../../utils/dialogs.dart' as dialogs;
import '../../widgets/my_app_bar.dart';
import 'bloc/bloc.dart';
import '../../theme/theme.dart';
import '../../widgets/app_list_item.dart';

class ManageSessionsContent extends StatelessWidget {
  const ManageSessionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ManageSessionsBloc>();

    // Al regresar avisa a la pantalla anterior (true) para que recargue las sesiones.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: Text(AppLocalizations.of(context)!.manageSessions),
        ),
        body: Padding(
          padding: AppSpacing.pageWithVertical,
          child: Column(
            children: [
              _text(context),
              const SizedBox(height: AppSpacing.lg),
              _listView(bloc),
            ],
          ),
        ),
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _text(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.deleteSessionsText,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget _listView(ManageSessionsBloc bloc) {
    return StreamBuilder<List<MapperDbModel>>(
      stream: bloc.sessions,
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<MapperDbModel>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                return _sessionListItem(context, snapshot.data![index]);
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _sessionListItem(BuildContext context, MapperDbModel mapperDbModel) {
    return AppListItem(
      title: '${mapperDbModel.alias}#${mapperDbModel.mapperId}',
      trailingIcon: Icons.delete_outline,
      onTap: () => _deleteSession(context, mapperDbModel.id!),
    );
  }

  /*
   * METHODS
   */
  void _deleteSession(BuildContext context, int id) {
    dialogs.showConfirmationDialog(
      context,
      text: AppLocalizations.of(context)!.deleteSession,
      acceptButtonText: AppLocalizations.of(context)!.yes,
      acceptCallback: () {
        BlocProvider.of<ManageSessionsBloc>(context).add(DeleteSession(id));
      },
    );
  }
}