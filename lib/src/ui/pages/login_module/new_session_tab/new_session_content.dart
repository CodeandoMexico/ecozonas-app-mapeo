import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dialogs/new_session_confirm_dialog.dart';
import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialogs.dart' as dialogs;
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
  String? _selectedGender;
  String? _selectedAge;
  String? _selectedDisability;

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
      backgroundColor: myTheme.colorScheme.background,
    );
  }

  Widget _body(BuildContext context, NewSessionBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Completa los siguientes datos para crear una nueva sesión',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.paddingXLarge),
          _genderDropdown(context, bloc),
          const SizedBox(height: Constants.paddingLarge),
          _ageDropdown(bloc),
          const SizedBox(height: Constants.paddingLarge),
          _disabilityDropdown(bloc),
          const SizedBox(height: Constants.paddingHuge),
          _continueButton(bloc)
        ],
      ),
    );
  }

  Widget _genderDropdown(BuildContext context, NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: 'Género',
      options: Constants.gender,
      callback: (value) {
        bloc.setGender(value);
        _selectedGender = value;
      },
    );
  }

  Widget _ageDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: 'Rango de edad',
      options: Constants.ageRange,
      callback: (value) {
        bloc.setAge(value);
        _selectedAge = value;
      },
    );
  }

  Widget _disabilityDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: 'Discapacidad',
      options: Constants.disability,
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
          label: 'Continuar',
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
          gender: _selectedGender!,
          age: _selectedAge!,
          disability: _selectedDisability!,
          callback: () {
            BlocProvider.of<NewSessionBloc>(context).add(CreateNewSession());
          },
        );
      },
    );
  }
}