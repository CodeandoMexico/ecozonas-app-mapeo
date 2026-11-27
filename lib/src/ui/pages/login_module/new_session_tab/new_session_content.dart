import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../../domain/models/sociodemographic_codes.dart';
import '../../../dialogs/new_session_confirm_dialog.dart';
import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialogs.dart' as dialogs;
import '../../../utils/utils.dart' as utils;
import '../../../widgets/my_bottom_sheet_text_field.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import 'bloc/bloc.dart';
import '../../new_id_module/new_id_page.dart';

class NewSessionContent extends StatefulWidget {
  final Function? callback;

  const NewSessionContent({super.key, this.callback});

  @override
  State<NewSessionContent> createState() => _NewSessionContentState();
}

class _NewSessionContentState extends State<NewSessionContent> {
  String? _selectedGender = SociodemographicCodes.noAnswer;
  String? _selectedAge = SociodemographicCodes.noAnswer;
  String? _selectedDisability = SociodemographicCodes.noAnswer;

  @override
  void initState() {
    super.initState();
    // Valores iniciales una sola vez: si se hiciera en build, cada
    // reconstrucción borraría lo que la persona ya eligió.
    final bloc = context.read<NewSessionBloc>();
    bloc.setGender(_selectedGender!);
    bloc.setAge(_selectedAge!);
    bloc.setDisability(_selectedDisability!);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewSessionBloc>();

    return Scaffold(
      body: BlocListener<NewSessionBloc, NewSessionState>(
        listener: (context, state) {
          if (state is CreatingNewSession) {
            dialogs.showLoadingDialog(context);
          } else {
            Navigator.pop(context);
          }
          if (state is NewSessionCreated) {
            widget.callback!();
            Navigator.pop(context);
            Navigator.pushNamed(context, NewIdPage.routeName, arguments: state.id);
          }
        },
        child: _body(context, bloc),
      ),
      backgroundColor: myTheme.colorScheme.surface,
    );
  }

Widget _body(BuildContext context, NewSessionBloc bloc) {
  return SingleChildScrollView( // Add scrollability
    child: Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/new_app_splash.png', height: 160),
          Text(
            AppLocalizations.of(context)!.completeData,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.paddingLarge), // Replace Spacer
          _genderDropdown(context, bloc),
          const SizedBox(height: Constants.paddingLarge),
          _ageDropdown(bloc),
          const SizedBox(height: Constants.paddingLarge),
          _disabilityDropdown(bloc),
          const SizedBox(height: Constants.paddingLarge), // Replace Spacer
          _continueButton(bloc),
        ],
      ),
    ),
  );
}


  Widget _genderDropdown(BuildContext context, NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.gender,
      options: utils.getGenderOptions(context),
      initialValue: _selectedGender,
      callback: (value) {
        bloc.setGender(value);
        _selectedGender = value;
      },
    );
  }

  Widget _ageDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.ageRange,
      options: utils.getAgeRange(context),
      initialValue: _selectedAge,
      callback: (value) {
        bloc.setAge(value);
        _selectedAge = value;
      },
    );
  }

  Widget _disabilityDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.disability,
      options: utils.getDisiability(context),
      initialValue: _selectedDisability,
      callback: (value) {
        bloc.setDisability(value);
        _selectedDisability = value;
      },
    );
  }

  Widget _continueButton(NewSessionBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.isValid,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return MyPrimaryElevatedButton(
          onPressed: snapshot.data == true ?
            () => _showConfirmDialog(context) :
            null,
            fullWidth: true,
          label: AppLocalizations.of(context)!.continueText,
        );
      },
    );
  }

  /*
   * METHODS
   */
  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NewSessionConfirmDialog(
          gender: utils.optionLabel(utils.getGenderOptions(context), _selectedGender!),
          age: utils.optionLabel(utils.getAgeRange(context), _selectedAge!),
          disability: utils.optionLabel(utils.getDisiability(context), _selectedDisability!),
          callback: () {
            BlocProvider.of<NewSessionBloc>(context).add(CreateNewSession());
          },
        );
      },
    );
  }
}
