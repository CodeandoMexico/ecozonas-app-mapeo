import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dialogs/new_session_confirm_dialog.dart';
import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/my_app_bar.dart';
import '../../../widgets/my_bottom_sheet_text_field.dart';
import '../../../widgets/my_primary_elevated_button.dart';
import 'bloc/bloc.dart';

class NewSessionContent extends StatelessWidget {
  NewSessionContent({super.key});

  final List<String> _gender = [
    'Hombre',
    'Mujer',
    'No binario',
    'Otro',
    'Prefiero no contestar',
  ];

  final List<String> _ageRange = [
    'Menos de 18 años',
    '19 - 25 años',
    '26 - 35 años',
    '36 - 45 años',
    '46 - 55 años',
    '56 - 65 años',
    '+66 años',
  ];

  final List<String> _disability = [
    'Motriz',
    'Visual',
    'Auditiva',
    'Cognitiva',
    'Ninguna',
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewSessionBloc>();
    
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Nueva sesión'),
      ),
      body: _body(context, bloc),
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
    // return MyDropdownButton(
    //   labelText: 'Género',
    //   items: _gender,
    //   onChange: (value) => bloc.setGender(value!),
    // );
    return MyBottomSheetTextField(
      titleText: 'Género',
      options: _gender,
      callback: (value) => bloc.setGender(value),
    );
  }

  Widget _ageDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: 'Rango de edad',
      options: _ageRange,
      callback: (value) => bloc.setAge(value),
    );
  }

  Widget _disabilityDropdown(NewSessionBloc bloc) {
    return MyBottomSheetTextField(
      titleText: 'Discapacidad',
      options: _disability,
      callback: (value) => bloc.setDisability(value),
    );
  }

  Widget _continueButton(NewSessionBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.isValid,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return MyPrimaryElevatedButton(
          onPressed: snapshot.data == true ? () {
            showDialog(
              context: context,
              builder: (context) {
                return const NewSessionConfirmDialog();  
              },
            );
          } : null,
          label: 'Continuar',
        );
      },
    );
  }
}