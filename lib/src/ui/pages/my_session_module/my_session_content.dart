import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../domain/models/db/mapper_db_model.dart';
import '../../utils/utils.dart' as utils;
import '../../widgets/alias_text_fields.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_bottom_sheet_text_field.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../login_module/tabs_container/login_tab_page.dart';
import 'bloc/bloc.dart';
import '../../theme/theme.dart';
import '../../widgets/app_button.dart';

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
      utils.showSnackBarSuccess(context, AppLocalizations.of(context)!.dataUpdated);
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
    return StreamBuilder(
      stream: bloc.mapper,
      builder: (BuildContext context, AsyncSnapshot<MapperDbModel> snapshot) {
        if (snapshot.hasData) {
          final mapper = snapshot.data!;
          aliasController.text = mapper.alias;

          final sectionStyle = Theme.of(context).textTheme.titleSmall;

          return Padding(
            padding: AppSpacing.pageWithVertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AppLocalizations.of(context)!.mappingId, style: sectionStyle),
                const SizedBox(height: AppSpacing.sm),
                AliasTextFields(
                  id: mapper.mapperId,
                  aliasController: aliasController,
                  callback: (value) {
                    bloc.setMapper(bloc.mapperValue.copyWith(alias: value));
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _copyButton(context, mapper.mapperId),
                const SizedBox(height: AppSpacing.xl),
                Text(AppLocalizations.of(context)!.yourData, style: sectionStyle),
                const SizedBox(height: AppSpacing.sm),
                _genderDropdown(context, bloc, mapper.gender),
                const SizedBox(height: AppSpacing.md),
                _ageDropdown(context, bloc, mapper.age),
                const SizedBox(height: AppSpacing.md),
                _disabilityDropdown(context, bloc, mapper.disability),
                const SizedBox(height: AppSpacing.xl),
                _saveButton(context, bloc, aliasController),
                const SizedBox(height: AppSpacing.sm),
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
    return AppButton.outline(
      fullWidth: true,
      onPressed: () async => await _copyToClipboard(id, context),
      label: AppLocalizations.of(context)!.copy,
      icon: Icons.copy,
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
    return AppButton.danger(
      label: AppLocalizations.of(context)!.logout,
      icon: Icons.logout,
      fullWidth: true,
      onPressed: () => Navigator.of(context).popUntil((route) => route.settings.name == LoginTabPage.routeName),
    );
  }

  /*
   * METHODS
   */
  Future<void> _copyToClipboard(int id, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: id.toString()));
    if (!context.mounted) return;
    utils.showSnackBar(context, AppLocalizations.of(context)!.copiedId);
  }
}