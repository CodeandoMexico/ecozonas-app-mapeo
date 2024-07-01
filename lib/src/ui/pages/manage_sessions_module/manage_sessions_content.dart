import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/db/mapper_db_model.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart' as dialogs;
import '../../widgets/my_app_bar.dart';
import 'bloc/bloc.dart';

class ManageSessionsContent extends StatelessWidget {
  const ManageSessionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ManageSessionsBloc>();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: Text(AppLocalizations.of(context)!.manageSessions),
        ),
        body: Column(
          children: [
            _text(context),
            _listView(bloc),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _text(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Text(
        AppLocalizations.of(context)!.deleteSessionsText,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(ManageSessionsBloc bloc) {
    return StreamBuilder<List<MapperDbModel>>(
      stream: bloc.sessions,
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<MapperDbModel>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
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
    return GestureDetector(
      onTap: () => _deleteSession(context, mapperDbModel.id!),
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF494949), width: 1),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${mapperDbModel.alias}#${mapperDbModel.mapperId}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Constants.labelTextColor,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            const Icon(Icons.delete_outline, size: 26)
          ],
        ),
      ),
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