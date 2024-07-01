import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/db/mapper_db_model.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart' as utils;
import '../../widgets/alias_text_fields.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_bottom_sheet_text_field.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../../widgets/my_secondary_elevated_button.dart';
import 'bloc/bloc.dart';

class MySessionContent extends StatelessWidget {
  MySessionContent({super.key});

  final aliasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MySessionBloc>();

    return Scaffold(
      appBar: _appBar(context),
      body: BlocListener<MySessionBloc, MySessionState>(
        listener: _states,
        child: SingleChildScrollView(
          child: _body(bloc)
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /*
   * STATES
   */
  void _states(context, state) {
    if (state is UpdateSuccessful) {
      utils.showSnackBarSuccess(context, 'Información actualizada correctamente');
    }
  }

  /*
   * APPBAR
   */
  MyAppBar _appBar(BuildContext context) {
    return MyAppBar(
      title: Text(AppLocalizations.of(context)!.mySession),
      hideBackButton: true,
    );
  }

  /*
   * WIDGETS
   */
  Widget _body(MySessionBloc bloc) {
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF646464));

    return StreamBuilder(
      stream: bloc.mapper,
      builder: (BuildContext context, AsyncSnapshot<MapperDbModel> snapshot) {
        if (snapshot.hasData) {
          final mapper = snapshot.data!;
          aliasController.text = mapper.alias;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.mappingId, style: style),
                const SizedBox(height: Constants.padding),
                AliasTextFields(
                  id: mapper.mapperId,
                  aliasController: aliasController,
                  callback: (value) {
                    bloc.setMapper(bloc.mapperValue.copyWith(alias: value));
                  },
                ),
                const SizedBox(height: Constants.padding),
                _copyButton(context, mapper.mapperId),
                const SizedBox(height: Constants.paddingXLarge),
                Text(AppLocalizations.of(context)!.yourData, style: style),
                const SizedBox(height: Constants.padding),
                _genderDropdown(context, bloc, mapper.gender),
                const SizedBox(height: Constants.paddingLarge),
                _ageDropdown(context, bloc, mapper.age),
                const SizedBox(height: Constants.paddingLarge),
                _disabilityDropdown(context, bloc, mapper.disability),
                const SizedBox(height: Constants.paddingXLarge),
                _saveButton(context, bloc, aliasController),
                const SizedBox(height: Constants.padding),
                _logoutButton(context)
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _copyButton(BuildContext context, int id) {
    return MySecondaryElevatedButton(
      onPressed: () async => await _copyToClipboard(id, context),
      label: AppLocalizations.of(context)!.copy,
      iconData: Icons.copy,
    );
  }

  Widget _genderDropdown(BuildContext context, MySessionBloc bloc, String gender) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.gender,
      options: utils.getGenderOptions(context),
      initialValue: gender,
      callback: (value) {
        bloc.setMapper(bloc.mapperValue.copyWith(gender: value));
      },
    );
  }

  Widget _ageDropdown(BuildContext context, MySessionBloc bloc, String age) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.ageRange,
      options: utils.getAgeRange(context),
      initialValue: age,
      callback: (value) {
        bloc.setMapper(bloc.mapperValue.copyWith(age: value));
      },
    );
  }

  Widget _disabilityDropdown(BuildContext context, MySessionBloc bloc, String disability) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.disability,
      options: utils.getDisiability(context),
      initialValue: disability,
      callback: (value) {
        bloc.setMapper(bloc.mapperValue.copyWith(disability: value));
      },
    );
  }

  MyPrimaryElevatedButton _saveButton(BuildContext context, MySessionBloc bloc, TextEditingController controller) {
    return MyPrimaryElevatedButton(
      label: AppLocalizations.of(context)!.save,
      onPressed: () {
        bloc.setMapper(bloc.mapperValue.copyWith(alias: controller.text));
        BlocProvider.of<MySessionBloc>(context).add(UpdateMapper());
      },
      fullWidth: true,
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Constants.redColor)
        )
      ),
      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      child: Text(
        AppLocalizations.of(context)!.logout,
        style: const TextStyle(
          color: Constants.redColor,
          fontWeight: FontWeight.w500,
          fontSize: 18
        )
      )
    );
  }

  /*
   * METHODS
   */
  Future<void> _copyToClipboard(int id, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: id.toString())).then((value) {
      utils.showSnackBar(context, AppLocalizations.of(context)!.copiedId);
    });
  }
}