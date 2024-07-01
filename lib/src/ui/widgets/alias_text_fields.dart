import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/theme.dart';
import '../utils/constants.dart';

class AliasTextFields extends StatelessWidget {
  final int id;
  final TextEditingController aliasController;
  final Function(String)? callback;

  const AliasTextFields({super.key, required this.id, required this.aliasController, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: myTheme.colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(Constants.borderRadiusSmall)
      ),
      child: Row(
        children: [
          _aliasTextField(context, aliasController),
          _divider(),
          _idText(id),
        ],
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _aliasTextField(BuildContext context, TextEditingController aliasController) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: TextFormField(
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          controller: aliasController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.writeYourName,
            border: InputBorder.none,
            suffixIcon: const Icon(Icons.edit_outlined, color: Colors.black)
          ),
          onChanged: (value) {
            if (callback != null) {
              callback!(value);
            }
          },
        ),
      )
    );
  }

  Widget _divider() {
    return Container(
      color: Constants.labelTextColor,
      width: 1,
      height: 30,
    );
  }

  Widget _idText(int id) {
    return Flexible(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '#$id',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}